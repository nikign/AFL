import filecmp
import getopt
import inspect
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
    bc_modified = "modified_%s" %bc_file
    current_file_path = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
    llvm_full_path = os.path.join(current_file_path, './afl-llvm-pass.so')
    set_BB_counter_full_path = os.path.join(current_file_path, './set-counter-BBid-llvm-pass.so')
    afl_rt_path = os.path.join(current_file_path, "afl-llvm-rt.o")
    os.environ["BB_LOGFILE_NAME"] = logfile_name
    for i in range(0, test_count):
        os.system('clang-6.0 -S -emit-llvm -Xclang -load -Xclang %s %s %s %s -o %s' % (set_BB_counter_full_path, bc_file, afl_rt_path, flags, bc_modified))
        os.system('clang-6.0 -Xclang -load -Xclang %s %s %s %s -o %s' % (llvm_full_path, bc_modified, afl_rt_path, flags, output_bc))
        if not os.path.isfile(logfile_name):
            print("Output file was not generated successfully.")
            continue
        os.rename(logfile_name, "%s_%d" %(logfile_name, i))
        if first_counter != i:
            equal = filecmp.cmp("%s_%d" %(logfile_name, i), "%s_%d" %(logfile_name, first_counter))
            if not equal:
                print("Results of two runs not identical: %d vs %d" %(i, test_count))
                exit()

if __name__ == "__main__":
   main(sys.argv[1:])
