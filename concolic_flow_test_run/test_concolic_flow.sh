set -e
echo "** setting up environment **"
#include full path to the virtual environment with wllvm installed
source "/usr/local/google/home/nikign/AFL/wllvm/bin/activate"
export LLVM_COMPILER="clang"
export PATH="$PATH:~/klee/build/bin/"
export LLVM_CC_NAME="clang-6.0"
export LLVM_CXX_NAME="clang++-6.0" 
export LLVM_CONFIG="/usr/bin/llvm-config-6.0"
# You might need to change the full path of AFL directory in the script. Currently, it looks for it in ~/AFL
 
echo "** compiling test-instr.c **"
wllvm ../Tests/test_program/test_instr.c -o ./test_instr.o
extract-bc ./test_instr.o -o ./test_instr.bc

echo "** compiling test-instr with set-counter-BBid-llvm-pass **"
clang-6.0 -c -emit-llvm -Xclang -load -Xclang ../set-counter-BBid-llvm-pass.so test_instr.bc -o ./test_instr_modified_pass1.bc

echo " ** generating human readable version of test-instr_modified_pass1 **"
clang-6.0 --gcc-toolchain="/usr/bin/gcc-8" -S -emit-llvm test_instr_modified_pass1.bc -o test_instr_modified_pass1.ll

echo "** compiling test_instr_modified_pass1 with afl-llvm-pass **"
clang-6.0 -Xclang -load -Xclang ../afl-llvm-pass.so test_instr_modified_pass1.bc ../afl-llvm-rt.o -o ./test_instr_modified_pass2.o

echo "** comparing runs for consistency across several runs **"
python3 ../compare_runs.py -i test_instr.bc -o ./test-instr-compare-runs.bc -n 5 -l compare_runs_log.txt

echo "** generating coverage information for test_instr_modified_pass2 **"
../counter_BBid_coverage -o coverage.txt -A ../Tests/test_inputs/example1.txt -- ~/AFL/concolic_flow_test_run/test_instr_modified_pass2.o @@

rm -rf ../Tests/coverage_out
mkdir ../Tests/coverage_out
echo "** generating collective coverage information for test_instr_modified_pass2 **"
python3 ../collective_coverage.py -i ../Tests/test_inputs/ -o ./coverage_out/ -f ~/AFL/concolic_flow_test_run/test_instr_modified_pass2.o -c collective_coverage_out.txt

echo "** running counter_BBid_coverage test in AFL/Tests**"
python3 ../Tests/test_counter_BBid_coverage.py coverage_out/

echo "** compiling klee_driver and klee_mock **"
wllvm++ -stdlib=libc++ -std=c++11 -O2 -c ../klee/klee_driver.cpp -o ./klee_driver.o 
ar r ./libAFL.a ./klee_driver.o 
clang-6.0 -O2 -c -fPIC ../klee/klee_mock.c -o ./klee_mock.o 
clang-6.0 -shared -o ./libKleeMock.so ./klee_mock.o

echo "** compiling klee example code **"
wllvm -c ../klee/klee_test_example.c -o klee_test_example.o

echo "** linking klee example and klee driver**"
wllvm++ ./klee_driver.o ./klee_test_example.o ./klee_mock.o -I ~/klee/build/include -o ./compiled_klee_driver.o
extract-bc compiled_klee_driver.o -o compiled_klee_driver.bc

echo "** compiling final linked klee driver with set-counter-BBid-llvm-pass **"
clang-6.0 -c -emit-llvm -Xclang -load -Xclang ../set-counter-BBid-llvm-pass.so compiled_klee_driver.bc -o ./modified_klee_driver_pass1.o

echo "** running compiled file with KLEE **"
~/klee/build/bin/klee --libc=uclibc -posix-runtime -output-dir klee_output modified_klee_driver_pass1.o 512
