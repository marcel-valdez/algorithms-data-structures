require "test/unit"
require_relative "../../src/chapter_1/Chapter1Exercises"
require_relative "../test_helper"

class Chapter1Exercises_test < TestHelper


  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @target = Chapter1Exercises.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  def check_string_result (result)
    !result.nil? and result.instance_of? String
  end

  def test_exercise_113
    verify_method :exercise_113,
                  :with => [{param: "1 2 3", expected: false},
                            {param: "1 1 1", expected: true}]
  end

  def test_exercise_115
    verify_method :exercise_115,
                  :with => [{param: [0.8, 0.8], expected: true},
                            {param: [0.1, 0.1], expected: true},
                            {param: [0.9, 0.9], expected: true},
                            {param: [1, 1], expected: false},
                            {param: [0, 0], expected: false}]
  end


  def test_exercise_116

    verify_method :exercise_116,
                  :with => [{predicate: method(:check_string_result)}]

    puts @target.exercise_116
  end

  # Give the values printed by the functions described in exercise 1.1.7
  def test_exercise_117
    verify_method :exercise_117, :with => [{predicate: method(:check_string_result)}]

    puts @target.exercise_117

  end

  # Write a method that returns a string with the binary representation of N
  def test_exercise_119
    verify_method :exercise_119,
                  :with => [{param: 1, expected: "1"},
                            {param: 2, expected: "10"},
                            {param: 3, expected: "11"},
                            {param: 8, expected: "1000"},
                            {param: 11, expected: "1011"}]
  end

  # Write a program that prints a Matrix with a header with the index of the columns
  # and the index of the row, example:
  # input: [3, 4]  output: " 12\n" +
  #        [5, 6]          "134\n" +
  #                        "256\n"
  def test_exercise_1111
    verify_method :exercise_1111,
                  :with => [{param: [[true]], expected: " 1\n1*\n"},
                            {param: [[false]], expected: " 1\n1 \n"},
                            {param: [[true, false]], expected: " 12\n1* \n"},
                            {param: [[true, false], [true, false]], expected: " 12\n1* \n2* \n"}]
  end

  # Write a method that receives a matrix NxM and transposes rows into columns MxN
  def test_exercise_1113
    verify_method :exercise_1113,
                  :with => [{param: [[0]], expected: [[0]]},
                            {param: [[0, 1]],
                             expected: [[0],
                                        [1]]},
                            {param: [[0, 1],
                                     [2, 3]],
                             expected: [[0, 2],
                                        [1, 3]]}]

  end

  # Write a method that calculates log2 of N, without using Math.log2
  def test_exercise_1114
    verify_method :exercise_1114,
                  :with => [{param: 2, expected: Math.log2(2).truncate},
                            {param: 3, expected: Math.log2(3).truncate},
                            {param: 9, expected: Math.log2(9).truncate},
                            {param: 90, expected: Math.log2(90).truncate}]
  end

  # Write a method that count the times a number appears in an array and
  # stores this count in another array, example: [0, 1, 1] result: [1, 2]
  def test_exercise_1115
    verify_method :exercise_1115,
                  :with => [{params: [[0], 1], expected: [1]},
                            {params: [[0], 2], expected: [1, 0]},
                            {params: [[1, 1], 2], expected: [0, 2]},
                            {params: [[1, 2, 3, 3, 3, 4], 5], expected: [0, 1, 1, 3, 1]}]
  end


  def recursive_fibonacci (n)
    return 0 if n == 0
    return 1 if n == 1

    recursive_fibonacci(n - 1) + recursive_fibonacci(n -2)
  end

  def calc_all_fibonacci (n)
    result = Array.new n + 1
    (0..n).each { |i| result[i] = recursive_fibonacci(i) }

    result
  end

  # Write a program with better performance (5x faster) than calc_all_fibonacci
  # to calculate all fibonacci numbers between 0 to N and store them in an array
  def test_exercise_1119
    expected_result = nil
    time_span = time_block { expected_result = calc_all_fibonacci 20 }
    verify_method :exercise_1119,
                  :with => [{param: 20, expected: expected_result}]

    actual_time_span = time_block { @target.exercise_1119 20 }

    assert_true actual_time_span < time_span / 5
  end

  # Write a program that calculates the value ln(N!)
  def test_exercise_1120
    verify_method :exercise_1120,
                  :with => [{param: 1, expected: Math.log(1).truncate},
                            {param: 2, expected: Math.log(2).truncate},
                            {param: 4, expected: Math.log(4 * 3 * 2).truncate},
                            {param: 3, expected: Math.log(3 * 2).truncate}]
  end

  # Write a program that reads in lines from standard input with each line
  # containing a name and two integers and then uses printf to print a table
  # with a column of the names, the integers, and result of dividing the first
  # by the second, accurate to 3 decimal places. You could use a program like this
  # to tabulate batting averages for baseball players or grades for students
  def test_exercise_1121

  end

end