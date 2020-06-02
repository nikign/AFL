import filecmp
import getopt
import os
import sys


def get_arguments(argv):
    bc_file = ''
    output_bc = ''
    test_count = 2
    try:
        opts, args = getopt.getopt(argv,"hi:o:n:",[])
    except getopt.GetoptError:
        print('compare_runs.py -i <input_bc_file> -o <output_bc_file> -n <re-run_counts>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('compare_runs.py -i <input_bc_file> -o <output_bc_file> -n <re-run_counts>')
            sys.exit()
        elif opt == '-i':
            bc_file = arg
        elif opt == '-o':
            output_bc = arg
        elif opt == '-n':
            test_count = int(arg)
    return bc_file, output_bc, test_count


def main(argv):
    bc_file, output_bc, test_count = get_arguments(argv)
    first_counter = 0
    os.system('rm -f block_id_info.txt')

    for i in range(0, test_count):
        print("%d %d" %(i, first_counter))
        os.system('clang -Xclang -load -Xclang ./afl-llvm-pass.so %s afl-llvm-rt.o -ldl -pthread -lcrypt -o %s' %(bc_file, output_bc))
        os.system('mv block_id_info.txt block_id_info_%d.txt' % i)
        if first_counter != i:
            equal = filecmp.cmp('block_id_info_%d.txt' % i, 'block_id_info_%d.txt' % first_counter)
            if not equal:
                print("Results of two runs not identical: %d vs %d" %(i, test_count))


if __name__ == "__main__":
   main(sys.argv[1:])
