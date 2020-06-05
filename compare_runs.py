import filecmp
import getopt
import os
import sys
import subprocess


def get_arguments(argv):
    bc_file = ''
    output_bc = ''
    test_count = 2
    flags = ''
    logfile_name = 'logfile'
    try:
        opts, args = getopt.getopt(argv,"hi:o:n:f:l:",[])
    except getopt.GetoptError:
        print('compare_runs.py -i <input_bc_file> -o <output_bc_file> -n <re-run_counts> -f "<clang_run_flags>" -l "<log_file_name>"')
        sys.exit(2)
    print(opts)
    for opt, arg in opts:
        if opt == '-h':
            print('compare_runs.py -i <input_bc_file> -o <output_bc_file> -n <re-run_counts> -f "<clang_run_flags>" -l "<log_file_name>"')
            sys.exit()
        elif opt == '-i':
            bc_file = arg
        elif opt == '-o':
            output_bc = arg
        elif opt == '-n':
            test_count = int(arg)
        elif opt == '-f':
            flags = arg
        elif opt == '-l':
            logfile_name = arg
            
    return bc_file, output_bc, test_count, flags, logfile_name


def main(argv):
    bc_file, output_bc, test_count, flags, logfile_name = get_arguments(argv)
    first_counter = 0
    current_full_path = os.getcwd()
    llvm_full_path = os.path.join(current_full_path, './afl-llvm-pass.so')
    afl_rt_path = os.path.join(current_full_path, 'afl-llvm-rt.o')
    print(logfile_name)
    os.environ["BB_LOGFILE_NAME"] = logfile_name
    for i in range(0, test_count):
        os.system('clang -Xclang -load -Xclang %s %s %s %s -o %s' % (llvm_full_path, bc_file, afl_rt_path, flags, output_bc))
        os.rename(logfile_name, "%s_%d" %(logfile_name, i))
        if first_counter != i:
            equal = filecmp.cmp("%s_%d" %(logfile_name, i), "%s_%d" %(logfile_name, first_counter))
            if not equal:
                print("Results of two runs not identical: %d vs %d" %(i, test_count))
                exit()

if __name__ == "__main__":
   main(sys.argv[1:])
