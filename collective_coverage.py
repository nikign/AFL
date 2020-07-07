import inspect
import getopt
import pathlib
import sys
import os


def get_full_path(filename):
    current_file_path = pathlib.Path(__file__).parent.absolute()
    return os.path.join(current_file_path, filename)


def process_arguments(argv):

    try:
        opts, args = getopt.getopt(argv,"hi:o:f:c:",[])

    except getopt.GetoptError:
        sys.exit('collective_coverage.py -i <input_dir_with_test_cases> -o <output_dir> -f <program_object_file_path> -c <collective_coverage_file> ')

    for opt, arg in opts:
        if opt == '-h':
            print('collective_coverage.py -i <input_dir_with_test_cases> -o <output_dir> -f <program_object_file_path> -c <collective_coverage_file>')
            sys.exit()
        elif opt == '-i':
            input_dir = arg
        elif opt == '-o':
            output_dir = arg
        elif opt == '-f':
            object_file = arg
        elif opt == '-c':
            collective_coverage_path = arg
            
    return input_dir, output_dir, object_file, collective_coverage_path


def run_program_on_tests(input_dir, output_dir, object_file):

    bb_coverage_path = get_full_path('./counter_BBid_coverage')
    test_inputs = os.listdir(input_dir)
    object_file_name = object_file.strip().split('/')[-1].split('.')[0]

    for input_name in test_inputs:
        input_file = os.path.join(input_dir, input_name)
        input_name = input_name.strip().split('.')[0]
        if not os.path.isfile(input_file):
            sys.exit("Input directory should only include input seed files and no directories.")
        coverage_file = os.path.join(output_dir, "%s_%s_coverage.txt" % (object_file_name, input_name))
        os.system('%s -o %s  -A %s -- %s @@' %(bb_coverage_path, coverage_file, input_file, object_file))


def calculate_collective_coverage(output_dir, collective_coverage_path):
    coverage_map = {}
    seed_count = 0
    for coverage_file_name in os.listdir(output_dir):
        coverage_file_path = os.path.join(output_dir, coverage_file_name)
        if not os.path.isfile(coverage_file_path):
            sys.exit("Output directory should only include output coverage files and should be empty before running this script.")
        seed_count += 1
        with open(coverage_file_path) as coverage_file:
            for line in coverage_file:
                coverage_list = line.strip().split(":")
                if len(coverage_list) != 2:
                    print('Invalid output file format in %s. Format should be "block id: coverage count" in each line.')
                    continue
                block_id, coverage = coverage_list[0], coverage_list[1]
                if block_id not in coverage_map:
                    coverage_map[block_id] = []
                coverage_map[block_id].append(coverage)

    if seed_count == 0:
        sys.exit("No valid test seeds were found.")

    with open(collective_coverage_path, 'w') as collective_coverage_file:
        for block_id in coverage_map:
            coverage_percentage = float(len(coverage_map[block_id]))/seed_count
            collective_coverage_file.write("%s:%f\n" %(block_id, coverage_percentage))


if __name__ == "__main__":
    input_dir, output_dir, object_file, collective_coverage_path = process_arguments(sys.argv[1:])

    if not os.path.isdir(input_dir):
        sys.exit("The input directory does not exist or is not a directory.")

    if not os.path.isdir(output_dir):
        sys.exit("The output directory does not exist or is not a directory.")

    run_program_on_tests(input_dir, output_dir, object_file)
    calculate_collective_coverage(output_dir, collective_coverage_path)
