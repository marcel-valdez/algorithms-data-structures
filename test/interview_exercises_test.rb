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

  # TODO: Write test for this exercise
  # write true random shuffle of N numbers, with O(N) complexity

  # TODO: Write test for this exercise
  # write a function that balances a tree with an unknown amount of input: it receives a stream of numbers
  # with n log2(n) complexity

  # TODO: Write test for this exercise
  # write a function that for an array of N numbers, determines if there is
  # a pair i,j that satisfies the condition: array[i] + array[j] == m
  # Test: That the function is correct
  #       That it is faster than the naive implementation.

  # Function that removes duplicate strings in an array of strings (where each string can be very long)
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

    if naive_time < actual_time * 2
      puts "naive time: #{naive_time}"
      puts "actual time: #{actual_time}"
    end

    assert_operator(actual_time * 2, :<, naive_time)
  end

  # Given a binary search tree in which each node has access to its parent node
  # write a function *find_path* that receives two *nodes*: source and destination
  # and returns the path to follow from the source to the destination.
  # If there is no route to the destination, write 'no path' where the
  # path cuts off.
  # Examples:
  # For the tree:
  #        root
  # left     5   right
  #       1      7
  #    -1   3   6 8
  #   -2 0 2 4
  #
  #    Input         Output
  # src:{1} dst:{5}  "1,5"
  # src:{5} dst:{7}  "5,7"
  # src:{-2} dst:{5} "-2,-1,1,5"
  # src:{-2} dst:{0} "-2,-1,0"
  # src:{4} dst:{2}  "4,3,2"
  # src:{2} dst:{6}  "2,3,1,5,7,6"
  # src:{2} dst:{10}  "n" <-- could be "2,3,1,5,7,8,n"
  #                                 as long as it ends with the letter 'n'
  def test_find_path
    # Arrange
    map = build_tree

    # Act
    verify_method :find_path,
                  with: [
                      # Assert
                      {params: [map[:five], map[:seven]], expect: "5,7"},
                      {params: [map[:seven], map[:five]], expect: "7,5"},
                      {params: [map[:five], map[:one]], expect: "5,1"},
                      {params: [map[:one], map[:five]], expect: "1,5"},
                      {params: [map[:minus_one], map[:five]], expect: "-1,1,5"},
                      {params: [map[:eight], map[:five]], expect: "8,7,5"},
                      {params: [map[:five], map[:eight]], expect: "5,7,8"},
                      {params: [map[:three], map[:one]], expect: "3,1"},
                      {params: [map[:one], map[:three]], expect: "1,3"},
                      {params: [map[:minus_one], map[:one]], expect: "-1,1"},
                      {params: [map[:minus_one], map[:three]], expect: "-1,1,3"},
                      {params: [map[:three], map[:minus_one]], expect: "3,1,-1"},
                      {params: [map[:one], map[:seven]], expect: "1,5,7"},
                      {params: [map[:seven], map[:one]], expect: "7,5,1"},
                      {params: [map[:three], map[:five]], expect: "3,1,5"},
                      {params: [map[:five], map[:three]], expect: "5,1,3"},
                      {params: [map[:six], map[:three]], expect: "6,7,5,1,3"},
                      {params: [map[:three], map[:six]], expect: "3,1,5,7,6"},
                      {params: [map[:two], map[:eight]], expect: "2,3,1,5,7,8"},
                      {params: [map[:eight], map[:two]], expect: "8,7,5,1,3,2"},
                      {params: [map[:four], map[:eight]], expect: "4,3,1,5,7,8"},
                      {params: [map[:eight], map[:four]], expect: "8,7,5,1,3,4"},
                      {params: [map[:minus_two], map[:eight]], expect: "-2,-1,1,5,7,8"},
                      {
                          params: [map[:minus_two], Node.new(9)],
                          predicate: Proc.new { |result| result.end_with? "n" }
                      },
                      {
                          params: [Node.new(-3), map[:eight]],
                          predicate: Proc.new { |result| result.end_with? "n" }
                      }
                  ]
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

  private

  # Builds the tree:
  #        root
  # left     5   right
  #       1      7
  #    -1   3   6 8
  #   -2 0 2 4
  # @return [Hash] a hash map where:
  #                  hash[:one] returns Node {1}
  #                  hash[:five] returns Node {5}
  #                  and so on.
  def build_tree
    map = {}
    map[:minus_two] = minus_two = Node.new(-2)
    map[:minus_one] = minus_one = Node.new(-1)
    map[:zero] = zero = Node.new(0)
    map[:one] = one = Node.new(1)
    map[:two] = two = Node.new(2)
    map[:three] = three = Node.new(3)
    map[:four] = four = Node.new(4)
    map[:five] = five = Node.new(5)
    map[:six] = six = Node.new(6)
    map[:seven] = seven = Node.new(7)
    map[:eight] = eight = Node.new(8)
    # first level
    five.left = one
    five.right = seven
    # second level
    one.left = minus_one
    one.right = three
    seven.left = six
    seven.right = eight
    # third level
    minus_one.left = minus_two
    minus_one.right = zero
    three.left = two
    three.right = four

    map
  end

  class Node
    attr_accessor :value, :left, :right, :parent

    # @param [Object] args
    def initialize(val, args = {})
      @value = val
      @left = args[:left]
      @right = args[:right]
      @parent = args[:parent]
    end

    # @param [Node] left_node
    def left=(left_node)
      @left = left_node
      left_node.parent = self
    end

    # @param [Node] right_node
    def right=(right_node)
      @right = right_node
      right_node.parent = self
    end

    def to_s
      left_val = !left.nil? ? left.value : nil
      right_val = !right.nil? ? right.value : nil
      "<val:#{value},l:#{left_val},r:#{right_val}>"
    end
  end
end
