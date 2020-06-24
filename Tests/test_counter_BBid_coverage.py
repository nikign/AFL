import inspect
import os
import sys


def get_full_path(filename):
    current_file_path = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
    return os.path.join(current_file_path, filename)


def calculate_coverage_for_file(object_file, test_input, coverage_file):
    bb_coverage_path = get_full_path('../counter_BBid_coverage')

    os.system('%s -o %s  -A %s -- %s @@ >/dev/null' %(bb_coverage_path, coverage_file, test_input, object_file))

    block_coverage = {}
    with open(coverage_file, 'r') as coverage_logs:
        for l in coverage_logs:
            coverage_info = l.strip().split(':')
            assert len(coverage_info)==2, 'Coverage format file should be block:coverage count'
            block, coverage = int(coverage_info[0]), int(coverage_info[1])
            assert block not in block_coverage, "Block ID should not be repeated in the coverage file. We have more than one entries with ID %s" % block
            block_coverage[block] = coverage

    os.remove(get_full_path(coverage_file))
    return block_coverage


def check_block_id_range(block_coverage, total_blocks):
    for i in block_coverage:
        assert 0 <= i <= total_blocks, "Block ID should be in the range of 0 to %d" % total_blocks


def generate_coverage_file_path(directory, obj_file, seed_file):
    obj_file_name = obj_file.strip().split('/')[-1].split('.')[0]
    seed_file_name = seed_file.strip().split('/')[-1].split('.')[0]
    coverage_file_name = "coverage_%s_%s.txt" %(obj_file_name, seed_file_name)
    coverage_file_path = os.path.join(directory, coverage_file_name)
    return coverage_file_path


def test_coverage_test_instr(output_dir):
    test_program = get_full_path('test_program/test_instr.o')
    output_dir_path = get_full_path(output_dir)

    test_input = get_full_path('test_inputs/example1.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 10)
    assert len(block_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 9, 'The first test case should cover 9 blocks of code but is covering %d' % len(block_coverage)
    assert block_coverage[9] == 1667, 'Wrong loop coverage. The for loop should be covered 1667 times (5000/3), but is %d times.' % block_coverage[9]
    assert block_coverage[3] == block_coverage[5] == 7, 'Since the test input has 7 lines, these parts should be covered 7 times, but are covered %d and %d times.' % (block_coverage[3], block_coverage[5])
    assert 8 not in block_coverage, 'Block 8 is only covered when the test file does not exist.'

    test_input = get_full_path('test_inputs/example2.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 10)
    assert len(block_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 9, 'The second test case should cover 9 blocks of code but is covering %d' % len(block_coverage)
    assert block_coverage[9] == 1667, 'Wrong loop coverage. The for loop should be covered 1667 times (5000/3), but is %d times.' % block_coverage[9]
    assert block_coverage[3] == block_coverage[5] == 4, 'Since the test input has 7 lines, these parts should be covered 7 times, but are covered %d and %d times.' % (block_coverage[3], block_coverage[5])
    assert 8 not in block_coverage, 'Block 8 is only covered when the test file does not exist.'

    test_input = get_full_path('test_inputs/example_not_exists.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 10)
    assert len(block_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 3, 'The third test case should cover 3 blocks of code but is covering %d' % len(block_coverage)
    assert 8 in block_coverage, 'File does not exist and line 8 should be covered.'
    assert 3 not in block_coverage, 'File does not exist so the process part of code should not be covered'

    test_input = get_full_path('test_inputs/example_empty_file.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 10)
    assert len(block_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 6, 'The fourth test case should cover 6 blocks of code but is covering %d' % len(block_coverage)
    assert 3 not in block_coverage, 'File is empty, so the process part of code should not be covered'
    assert 9 in block_coverage, 'Program should continue the part after file handling once the file is empty'



def test_coverage_test_instr2(output_dir):
    test_program = get_full_path('test_program/test_instr2.o')
    output_dir_path = get_full_path(output_dir)

    test_input = get_full_path('test_inputs/example1.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 30)
    # blocks 13, 15, 16, 28
    assert len(block_coverage) < 31, 'The test_instr.c file should only have 30 blocks.'
    assert len(block_coverage) == 11, 'The first test case should cover 11 blocks of code but is covering %d' % len(block_coverage)
    assert block_coverage[13] == 8, 'This block reads the file line by line, so it should be 1 more than the lines of data in file (8), but is %s' %block_coverage[13]
    assert 15 not in block_coverage, 'Block 15 is only covered if file is not found. Should not be covered by this seed.'
    assert block_coverage[16] == 7, 'The for loop should be covered equal to the lines of input, but is covered %d' % block_coverage[16]
    assert block_coverage[28] == 6, 'The for loop in the function starts at 1 and goes up to the line count of input, so it should be lines of input -1 but is %d' % block_coverage[28]
    assert 26 not in block_coverage, 'The switch case for len 0 should be skipped by this test'
    assert 27 not in block_coverage, 'The switch case for len 1 should be skipped by this test'
    assert 18 in block_coverage, 'The default for switch should be covered by this case'

    test_input = get_full_path('test_inputs/example2.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 30)
    assert len(block_coverage) < 31, 'The test_instr.c file should only have 30 blocks.'
    assert len(block_coverage) == 11, 'The second test case should cover 11 blocks of code but is covering %d' % len(block_coverage)
    assert block_coverage[13] == 5, 'This block reads the file line by line, so it should be 1 more than the lines of data in file (5), but is %s' %block_coverage[13]
    assert 15 not in block_coverage, 'Block 15 is only covered if file is not found. Should not be covered by this seed.'
    assert block_coverage[16] == 4, 'The for loop should be covered equal to the lines of input, but is covered %d' % block_coverage[16]
    assert block_coverage[28] == 3, 'The for loop in the function starts at 1 and goes up to the line count of input, so it should be lines of input -1 but is %d' % block_coverage[28]
    assert 26 not in block_coverage, 'The switch case for len 0 should be skipped by this test'
    assert 27 not in block_coverage, 'The switch case for len 1 should be skipped by this test'
    assert 18 in block_coverage, 'The default for switch should be covered by this case'

    test_input = get_full_path('test_inputs/example_not_exists.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 30)
    assert len(block_coverage) < 31, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 3, 'The third test case should cover 3 blocks of code but is covering %d' % len(block_coverage)
    assert 15 in block_coverage, 'Block 15 should be covered since this file does not exist, but it is not'
    assert 13 not in block_coverage, 'Since the file does not exist, the file reading parts should not be covered.'
    assert 17 not in block_coverage, 'The program should exit before the switch statement'


    test_input = get_full_path('test_inputs/example_empty_file.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 30)
    assert len(block_coverage) < 31, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 6, 'The fourth test case should cover 6 blocks of code but is covering %d' % len(block_coverage)
    assert 26 in block_coverage, 'The switch case for len 0 should be covered by this test'
    assert 27 not in block_coverage, 'The switch case for len 1 should be skipped by this test'
    assert 18 not in block_coverage, 'The default for switch should be skipped by this case'


    test_input = get_full_path('test_inputs/example_1_line.txt')
    coverage_file_path = generate_coverage_file_path(output_dir_path, test_program, test_input)
    block_coverage = calculate_coverage_for_file(test_program, test_input, coverage_file_path)
    check_block_id_range(block_coverage, 30)
    assert len(block_coverage) < 31, 'The test_instr.c file should only have 10 blocks.'
    assert len(block_coverage) == 8, 'The fifth test case should cover 8 blocks of code but is covering %d' % len(block_coverage)
    assert 26 not in block_coverage, 'The switch case for len 0 should be skipped by this test'
    assert 27 in block_coverage, 'The switch case for len 1 should be covered by this test'
    assert 18 not in block_coverage, 'The default for switch should be skipped by this case'

    # assert len(block_coverage) == 6, 'The fourth test case should cover 6 blocks of code but is covering %d' % len(block_coverage)
    # assert 3 not in block_coverage, 'File is empty, so the process part of code should not be covered'
    # assert 9 in block_coverage, 'Program should continue the part after file handling once the file is empty'



if __name__ == "__main__":
    coverage_directory = sys.argv[1]
    test_coverage_test_instr(coverage_directory)
    test_coverage_test_instr2(coverage_directory)