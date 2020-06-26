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

using namespace llvm;

namespace {

  class CounterBBid : public ModulePass {

    public:

      static char ID;
      CounterBBid() : ModulePass(ID) { }
      bool runOnModule(Module &M) override;

  };

}
char CounterBBid::ID = 0;

bool CounterBBid::runOnModule(Module &M) {

  LLVMContext &C = M.getContext();

  IntegerType *Int64Ty = IntegerType::getInt64Ty(C);

  /* Instrument all the things! */

  u64 block_counter = 1;
  
  for (auto &F : M){
    for (auto &BB : F) {

        assert(block_counter < MAP_SIZE && "counter is too large");
        std::string value = std::to_string(block_counter);
        MDString * S = MDString::get(C, value.c_str());
        MDNode* Meta = MDNode::get(C, S);
        for (Instruction& instr : BB.getInstList()) {
            instr.setMetadata("BBid", Meta);
            break;
        }
        block_counter++;
    }
  }

  return true;

}


static void registerCounterBBidPass(const PassManagerBuilder &,
                            legacy::PassManagerBase &PM) {

  PM.add(new CounterBBid());

}


static RegisterStandardPasses RegisterCounterBBidPass(
    PassManagerBuilder::EP_ModuleOptimizerEarly, registerCounterBBidPass);

static RegisterStandardPasses RegisterCounterBBidPass0(
    PassManagerBuilder::EP_EnabledOnOptLevel0, registerCounterBBidPass);
