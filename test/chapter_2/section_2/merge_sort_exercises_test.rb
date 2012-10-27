#encoding: utf-8

require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_2/merge_sort_exercises"

module Chapter2
  module Section2
    class MergeSortExercises_test < TestHelper

      def initialize(*args)
        super(*args)
        @target = MergeSortExercises.new
      end

      # 2.2.10 Faster merge. Implement a version of mergesort that copies the
      # second half of the input array to the auxiliary array in -decreasing order- and then
      # does the merge back to the input array. This change allows you to remove
      # the code to test that each of the halves has been exhausted from the inner loop.
      # Warning: The resulting sort is not stable.
      # Note: This test will check that the method produces correct sorts, and will
      #       also compare the execution time against the standard mergesort.
      def test_faster_merge_e2210
        verify_method :faster_merge_e2210,
                      :with => [
                          {param: [0], expect: [0]},
                          {param: [0, 1], expect: [0, 1]},
                          {param: [1, 0], expect: [0, 1]},
                          {param: [1, 2, 0], expect: [0, 1, 2]},
                          {param: [1, 5, 2, 0], expect: [0, 1, 2, 5]},
                          {param: [1, 5, 2, 7, 0], expect: [0, 1, 2, 5, 7]},
                          {param: [0, 1, 2, 5, 7], expect: [0, 1, 2, 5, 7]},
                      ]

        test_faster_merge_time()
      end

      # This is not an exercise, it helps test the execution time of exercise 2.2.10
      def test_faster_merge_time
        thousand_elements = (0..1000).to_a
        big_input = thousand_elements.shuffle
        standard_time = time_block {
          @aux = Array.new(big_input.length)
          merge_sort big_input, 0, big_input.length - 1
        }

        big_input = thousand_elements.shuffle
        faster_time = time_block {
          @target.faster_merge_e2210 big_input
        }

        assert_operator standard_time, :>, faster_time
      end

      def merge_sort(values, lo, hi)
        return values if hi <= lo
        mid = lo + (hi-lo)/2
        merge_sort(values, lo, mid)
        merge_sort(values, mid+1, hi)
        merge(values, lo, mid, hi)
      end

      def merge(input, lower_bound, mid, upper_bound)
        low_idx, hi_idx = lower_bound, mid+1

        input.each_with_index { |number, idx| @aux[idx] = number }

        i = lower_bound
        until i > upper_bound
          if low_idx > mid
            input[i] = @aux[hi_idx]
            hi_idx+=1
          elsif hi_idx > upper_bound
            input[i] = @aux[low_idx]
            low_idx+=1
          elsif @aux[hi_idx] < @aux[low_idx]
            input[i] = @aux[hi_idx]
            hi_idx+=1
          else
            input[i] = @aux[low_idx]
            low_idx+=1
          end

          i+=1
        end

        input
      end

      # This is not an exercise, its a test for the standard merge sort implementation
      def test_merge_sort_helper
        # Arrange
        cases = [{input: [0], expected: [0]},
                 {input: [0, 1], expected: [0, 1]},
                 {input: [0, 1, 2, 5, 7], expected: [0, 1, 2, 5, 7]},
                 {input: [1, 5, 2, 0], expected: [0, 1, 2, 5]}]

        cases.each { |test_case|
          # Act
          @aux = Array.new(test_case[:input].length)
          actual = merge_sort test_case[:input], 0, test_case[:input].length - 1

          # Assert
          assert_equal test_case[:expected], actual
        }
      end

      # This is not an exercise, it is a test for the merge method
      # used to help test the merge_sort standard implementation
      def test_merge
        # Arrange
        cases = [{input: [0, 3, 2, 1, 4], expected: [0, 1, 3, 2, 4]}]
        cases.each { |test_case|
          input = test_case[:input]
          mid = input[input.length/2]
          lo = 0
          hi = input.length - 1
          expected_output = test_case[:expected]
          @aux = Array.new(input.length)

          # Act
          output = merge(input, lo, mid, hi)

          # Assert
          assert_equal(expected_output, output)
        }
      end
    end
  end
end
