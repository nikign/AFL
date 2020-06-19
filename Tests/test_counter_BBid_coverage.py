import inspect
import os


def get_full_path(filename):
    current_file_path = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
    return os.path.join(current_file_path, filename)


def calculate_coverage_for_file(cpp_file, test_input):
    llvm_full_path = get_full_path('../afl-llvm-pass.so')
    afl_rt_path = get_full_path("../afl-llvm-rt.o")
    bb_coverage_path = get_full_path('../counter_BBid_coverage')

    bc_file = "%s.o.bc" % cpp_file
    object_file = "%s.o" % cpp_file
    coverage_file = './test_bb_coverage_out'

    os.system("wllvm %s -O3 -o %s.o -lstdc++" %(cpp_file, cpp_file))
    os.system("extract-bc %s.o" % cpp_file)
    os.system('clang  -Xclang -load -Xclang %s %s %s -o %s > /dev/null' % (llvm_full_path, bc_file, afl_rt_path, object_file))
    os.system('%s -o %s  -A %s -- %s @@ >/dev/null' %(bb_coverage_path, coverage_file, test_input, object_file))

    os.remove(object_file)
    os.remove(bc_file)

    line_coverage = {}
    with open(coverage_file, 'r') as coverage_logs:
        for l in coverage_logs:
            coverage_info = l.strip().split(':')
            assert len(coverage_info)==2, 'Coverage format file should be block:coverage count'
            block, coverage = int(coverage_info[0]), int(coverage_info[1])
            line_coverage[block] = coverage

    os.remove(get_full_path('test_bb_coverage_out'))
    return line_coverage


def test_coverage():
    test_program = get_full_path('test_program/test_instr.c')

    test_input = get_full_path('test_inputs/example1.txt')
    line_coverage = calculate_coverage_for_file(test_program, test_input)
    assert len(line_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert line_coverage[9] == 1667, 'Wrong loop coverage. The for loop should be covered 1667 times (5000/3), but is %d times.' % line_coverage[9]
    assert line_coverage[3] == line_coverage[5] == 7, 'Since the test input has 7 lines, these parts should be covered 7 times, but are covered %d and %d times.' % (line_coverage[3], line_coverage[5])
    assert 8 not in line_coverage, 'Block 8 is only covered when the test file does not exist.'

    test_input = get_full_path('test_inputs/example2.txt')
    line_coverage = calculate_coverage_for_file(test_program, test_input)
    assert len(line_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert line_coverage[9] == 1667, 'Wrong loop coverage. The for loop should be covered 1667 times (5000/3), but is %d times.' % line_coverage[9]
    assert line_coverage[3] == line_coverage[5] == 4, 'Since the test input has 7 lines, these parts should be covered 7 times, but are covered %d and %d times.' % (line_coverage[3], line_coverage[5])
    assert 8 not in line_coverage, 'Block 8 is only covered when the test file does not exist.'

    test_input = get_full_path('test_inputs/example_not_exists.txt')
    line_coverage = calculate_coverage_for_file(test_program, test_input)
    assert len(line_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert 8 in line_coverage, 'File does not exist and line 8 should be covered.'
    assert 3 not in line_coverage, 'File does not exist so the process part of code should not be covered'

    test_input = get_full_path('test_inputs/example_empty_file.txt')
    line_coverage = calculate_coverage_for_file(test_program, test_input)
    assert len(line_coverage) < 11, 'The test_instr.c file should only have 10 blocks.'
    assert 3 not in line_coverage, 'File is empty, so the process part of code should not be covered'
    assert 9 in line_coverage, 'Program should continue the part after file handling once the file is empty'


test_coverage()