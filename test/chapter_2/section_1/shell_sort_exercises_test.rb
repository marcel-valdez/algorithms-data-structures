#encoding: utf-8

require_relative '../../test_helper'
require_relative '../../../src/chapter_2/section_1/shell_sort_exercises'

module Chapter2
  module Section1
    class ShellSortExercisesTest < TestHelper

      def initialize(*args)
        super(*args)
        @target = ShellSortExercises.new
      end

      # 2.1.11 Implement a method that returns an array of the shell sort increment sequence.
      # Note: Use the decreasing values for (3**k - 1)/2, starting at the largest increment
      #       less than n/3, decreasing to 1
      #         The method will receive a value n, and be expected to return an array with
      #       the decrement sequence for such n
      # Assumptions: n > 3
      def test_e2111_shell_sort_increment
        verify_method :e2111_shell_sort_increment,
                      :with => [
                          {
                              param: 3,
                              predicate: Proc.new { |seq| check_shell_sort_sequence(3, seq) }
                          },
                          {
                              param: 4,
                              predicate: Proc.new { |seq| check_shell_sort_sequence(4, seq) }
                          },
                          {
                              param: 10,
                              predicate: Proc.new { |seq| check_shell_sort_sequence(10, seq) }
                          },
                          {
                              param: 100,
                              predicate: Proc.new { |seq| check_shell_sort_sequence(100, seq) }
                          },
                      ]
      end

      def check_shell_sort_sequence(size, seq)
        index = 0
        h = 1
        while h < size/3
          if seq[index] != h
            puts "Element #{index} of sequence is incorrect, should be #{h} but found #{seq[index]}"
            return false
          end
          h = (3*h)+1
          index += 1
        end

        if (index+1) != seq.length
          puts "The size of the sequence is incorrect, expected: #{index+1}, but found: #{seq.length}"
          return false
        end

        true
      end
    end
  end
end
