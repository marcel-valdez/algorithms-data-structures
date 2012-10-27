require_relative "test_helper"
require_relative "../src/interview_exercises"
require 'time'

class InterviewExercises_test < TestHelper
  def initialize (arg)
    super(arg)

    @target = InterviewExercises.new
  end


  # Write a method for reversing a string without using Ruby's built-in reverse.
  def test_reverse
     # Arrange
     even_input = "reverse this" # Check pair amount of chars
     odd_input = "reverse thisz" # Check odd amount of chars

     # Verify
     verify_reverse_behavior(even_input)
     verify_reverse_behavior(odd_input)
  end

  def verify_reverse_behavior (input)
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