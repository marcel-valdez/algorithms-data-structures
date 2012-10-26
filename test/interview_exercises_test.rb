require_relative "test_helper"
require_relative "../src/interview_exercises"
require 'time'

class InterviewExercises_test < TestHelper
  def initialize (arg)
    super(arg)

    @target = InterviewExercises.new
  end


  # Write a method for reversing a string with O(n/2) or better complexity, without
  # using the built-in Ruby reverse method.
  # Note: This test checks that the method provides a correct reverse
  #       implementation, and compares it's execution time vs. a naive implementation.
  def test_fast_reverse
     # Arrange
     even_input = "reverse this" # Check pair amount of chars
     odd_input = "reverse thisz" # Check odd amount of chars
     input_big = "reverse this" * 100

     verify_str_reverse_behavior(even_input)
     verify_str_reverse_behavior(odd_input)

     suboptimal_time = time_block { suboptimal_reverse input_big }
     actual_time = time_block { @target.fast_reverse(input_big) }

     # Assert
     assert_operator actual_time, :<, suboptimal_time
  end

  # This is not an exercise, its a test for the suboptimal_reverse
  # implementation provided here to help test the fast_reverse method.
  def test_suboptimal_reverse
    # Arrange
    input = "reverse this"
    expected = input.reverse

    # Act
    actual = suboptimal_reverse input

    # Assert
    assert_equal expected, actual
  end

  def suboptimal_reverse(input)
    result = ""
    for i in 0...input.length
      result += input[input.length-1-i]
    end

    result
  end

  def verify_str_reverse_behavior (input)
    expected = input.reverse

    # Act
    verify_method :fast_reverse,
                  with: {param: input, expect: expected}
  end

  # true random shuffle cards with N complexity

  # function that balances a tree with an unknown amount of input: it receives a stream of numbers
  # with n log2(n) complexity

  # function that removes duplicate lines in an array of lines (where each line can be very long)
  # with a complexity of O((Hash Search of 1..n) * n)
end