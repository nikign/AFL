/*
  Copyright 2015 Google LLC All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

/*
   american fuzzy lop - LLVM-mode instrumentation pass
   ---------------------------------------------------

   Written by Laszlo Szekeres <lszekeres@google.com> and
              Michal Zalewski <lcamtuf@google.com>

   LLVM integration design comes from Laszlo Szekeres. C bits copied-and-pasted
   from afl-as.c are Michal's fault.

   This library is plugged into LLVM when invoking clang through afl-clang-fast.
   It tells the compiler to add code roughly equivalent to the bits discussed
   in ../afl-as.h.
*/

#define AFL_LLVM_PASS

#include "../config.h"
#include "../debug.h"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fstream>
#include<iostream>
#include <inttypes.h>

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

  class AFLCoverage : public ModulePass {

    public:

      static char ID;
      AFLCoverage() : ModulePass(ID) { }
      bool runOnModule(Module &M) override;

  };

}


SmallString<32> getmd5(std::string input){
    MD5 md5_maker = MD5();
    md5_maker.update(input);
    llvm::MD5::MD5Result md5_result;
    md5_maker.final(md5_result);
    SmallString<32> md5_str;
    md5_maker.stringifyResult(md5_result, md5_str);
    return md5_str;
}


char AFLCoverage::ID = 0;


u64 getBBCounter(BasicBlock *BB) {
  MDNode* BBid_meta;
  u64 block_counter;
  if (BB->size() == 0)
    FATAL("There is a basic block with no instructions in the program.");
  for (Instruction& instr : BB->getInstList()) {
        if (!instr.hasMetadata())
          FATAL("The first instruction of the block should include block id, have you instrumented the code with set-counter-BBid-llvm-pass first?");
        BBid_meta = instr.getMetadata("BBid");
        break;
  }
  std::string meta_string = cast<MDString>(BBid_meta->getOperand(0))->getString();
  block_counter = std::strtoull(meta_string.c_str(), NULL, 16);
  if (block_counter == ULLONG_MAX)
    FATAL("The format of the BBid did not match an unsigned int.");
  if (block_counter == 0)
    FATAL("The format of the BBid did not match an unsigned int.");
  return(block_counter);
}



bool AFLCoverage::runOnModule(Module &M) {

  LLVMContext &C = M.getContext();

  IntegerType *Int64Ty = IntegerType::getInt64Ty(C);

  /* Show a banner */

  char be_quiet = 0;

  if (isatty(2) && !getenv("AFL_QUIET")) {

    SAYF(cCYA "afl-llvm-pass " cBRI VERSION cRST " by <lszekeres@google.com>\n");

  } else be_quiet = 1;

  /* Get globals for the SHM region. */

  GlobalVariable *BBCoverageMapPtr =
      new GlobalVariable(M, PointerType::get(Int64Ty, 0), false,
                         GlobalValue::ExternalLinkage, 0, "__bb_coverage_ptr");

  /* Instrument all the things! */

  u64 block_counter;
  std::ofstream location_file;
  std::error_code llvm_of_error; 
  const char* output_file_name = std::getenv("BB_LOGFILE_NAME");

  if (output_file_name != nullptr) {
    location_file.open(output_file_name, std::ios::trunc);
    if (location_file.fail()){
      FATAL("Output log file \"%s\" could not be opened successfully. The logs cannot be saved.\n", output_file_name);
    }
  }
  
  for (auto &F : M){

    for (auto &BB : F) {
      BasicBlock::iterator IP = BB.getFirstInsertionPt();
      IRBuilder<> IRB(&(*IP));

      /* Make up cur_loc based on block counter */
      block_counter = getBBCounter(&BB);
      if (block_counter > MAP_SIZE)
        FATAL("counter is too large");
      ConstantInt *CurBB = ConstantInt::get(Int64Ty, block_counter);

      /* Load SHM pointer */

      LoadInst *MapPtr = IRB.CreateLoad(BBCoverageMapPtr);
      MapPtr->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));
      Value *MapPtrIdx = IRB.CreateGEP(MapPtr,  CurBB);

      /* Update bitmap */

      LoadInst *Counter = IRB.CreateLoad(MapPtrIdx);
      Counter->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));
      Value *Incr = IRB.CreateAdd(Counter, ConstantInt::get(Int64Ty, 1));
      IRB.CreateStore(Incr, MapPtrIdx)
          ->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));

      if (location_file.is_open()){
        /* Make a raw_string_ostream to save the content of a block into a string */

        std::string block_string;
        llvm::raw_string_ostream block_string_stream(block_string);
        block_string_stream << BB;
        SmallString<32> block_md5 = getmd5(block_string_stream.str());
        location_file << M.getSourceFileName() << ":" << F.getName().str() << ":" << block_md5.c_str() << ":" << block_counter << "\n";

      }

    }
  }
  if (location_file.is_open()){
    location_file.close();
  }

  /* Say something nice. */

  if (!be_quiet) {

    if (!block_counter) WARNF("No instrumentation targets found.");
    else OKF("Instrumented %llu locations (%s mode).",
             block_counter, getenv("AFL_HARDEN") ? "hardened" :
             ((getenv("AFL_USE_ASAN") || getenv("AFL_USE_MSAN")) ?
              "ASAN/MSAN" : "non-hardened"));

  }

  return true;

}


static void registerAFLPass(const PassManagerBuilder &,
                            legacy::PassManagerBase &PM) {

  PM.add(new AFLCoverage());

}


static RegisterStandardPasses RegisterAFLPass(
    PassManagerBuilder::EP_ModuleOptimizerEarly, registerAFLPass);

static RegisterStandardPasses RegisterAFLPass0(
    PassManagerBuilder::EP_EnabledOnOptLevel0, registerAFLPass);
