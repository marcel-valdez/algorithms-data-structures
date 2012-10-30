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


  # function that removes duplicate strings in an array of strings (where each string can be very long)
  # and there could be millions of strings.
  # Assumption: Assume that the string will only contain letters a-z and A-Z
  # Note: Do not compare all strings vs. all strings.
  # The test will check that the function removes duplicate strings and that it performs at least,
  # twice faster than the naive implementation.
  def test_remove_duplicate_lines

    verify_method :remove_duplicate_lines,
                  with: [
                      {
                          param: %w(a a),
                          expect: %w(a)
                      },
                      {
                          param: %w(aa aa),
                          expect: %w(aa)
                      },
                      {
                          param: %w(ab ab),
                          expect: %w(ab)
                      },
                      {
                          param: %w(a aa),
                          expect: %w(a aa)
                      },
                      {
                          param: %w(a b),
                          expect: %w(a b)
                      },
                      {
                          param: %w(a b b),
                          expect: %w(a b)
                      },
                      {
                          param: %w(a aa aaa aaaa aa aab aaa aabcc aabc),
                          expect: %w(a aa aaa aaaa aab aabcc aabc)
                      },
                  ]

    random_lines = generate_random_lines(1000)
    naive_time = time_block { naive_remove_duplicate_lines(random_lines) }
    actual_time = time_block { @target.remove_duplicate_lines(random_lines) }

    #puts "naive time: #{naive_time}"
    #puts "actual time: #{actual_time}"
    assert_operator(actual_time * 2, :<, naive_time)
  end

  def generate_random_lines(line_count)
    lines = Array.new(line_count)
    alphabet = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    (0..line_count).each { |i|
      lines[i] = "" + (0...(rand(50)+1)).map { alphabet[rand(alphabet.length)] }.join
    }

    lines
  end

  def naive_remove_duplicate_lines(lines)
    distinct_lines = []
    lines.each { |line| distinct_lines << line if not distinct_lines.include? line }
    distinct_lines
  end
end