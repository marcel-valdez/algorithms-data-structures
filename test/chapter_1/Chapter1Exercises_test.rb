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

  def check_string_result result
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

  def test_exercise_117
    verify_method :exercise_117, :with => [{predicate: method(:check_string_result)}]

    puts @target.exercise_117

  end

  def test_exercise_119
    verify_method :exercise_119,
                  :with => [{param: 1, expected: "1"},
                            {param: 2, expected: "10"},
                            {param: 3, expected: "11"},
                            {param: 8, expected: "1000"},
                            {param: 11, expected: "1011"}]
  end

  def test_exercise_1111
    verify_method :exercise_1111,
                  :with => [{param: [[true]], expected: " 1\n1*\n"},
                            {param: [[false]], expected: " 1\n1 \n"},
                            {param: [[true, false]], expected: " 12\n1* \n"},
                            {param: [[true, false], [true, false]], expected: " 12\n1* \n2* \n"}]
  end

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

  def test_exercise_1114
     verify_method :exercise_1114,
    :with => [{param: 2, expected: Math.log2(2).truncate},
              {param: 3, expected: Math.log2(3).truncate},
              {param: 9, expected: Math.log2(9).truncate},
              {param: 90, expected: Math.log2(90).truncate}]
  end

  def test_exercise_1115

  end

  def test_exercise_1116

  end

  def test_exercise_1117

  end

  def test_exercise_1118

  end

  def test_exercise_1119

  end

  def test_exercise_1120

  end

end