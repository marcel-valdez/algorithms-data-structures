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
        verify_correctness(:faster_merge_e2210)

        check_faster_than_standard(:faster_merge_e2210)
      end

      def verify_correctness(method)
        verify_method method,
                      :with => [
                          {param: [0], expect: [0]},
                          {param: [0, 1], expect: [0, 1]},
                          {param: [1, 0], expect: [0, 1]},
                          {param: [1, 2, 0], expect: [0, 1, 2]},
                          {param: [1, 5, 2, 0], expect: [0, 1, 2, 5]},
                          {param: [1, 5, 2, 7, 0], expect: [0, 1, 2, 5, 7]},
                          {param: [0, 1, 2, 5, 7], expect: [0, 1, 2, 5, 7]},
                      ]
      end

      # 2.2.11 Improvements. Implement the three improvements to mergesort described
      # in the Algorithms 4th ed book. These are:
      # 1) Add a cutoff for small subarrays. Use insertion sort for these.
      # 2) Test whether the array is already in order. if a[mid] <= a[mid+1] don't merge.
      # 3) Avoid the auxiliary copy, by switching arguments in the recursive code.
      #    Two invocations to sort:
      #       1) input array as its parameter, and put the output in the aux array
      #       2) aux array as its parameter, and put sorted output in the input array
      # Note: The test will check 4 things:
      #       1) That the sorted result is correct
      #       2) That it executes at least twice as fast for a sorted array
      #          than the standard merge sort.
      #       3) That it runs faster than the standard merge sort
      #       4) That it runs faster than the implementation of exercise 2.2.10.
      #          So you need to solve exercise 2.2.10 first. ;)
      def test_merge_improvements_e2211
        #       1) That the sorted result is correct
        verify_correctness :merge_improvements_e2211

        #       2) That it executes at least twice as fast for a sorted array
        #          than the standard merge sort.
        check_faster_for_sorted_array()

        #       3) That it runs faster than the standard merge sort
        check_faster_than_standard(:merge_improvements_e2211)

        #       4) That it runs faster than the implementation of exercise 2.2.10.
        #          So you need to solve exercise 2.2.10 first. ;)
        thousand_elements = (0..1000).to_a
        big_input = thousand_elements.shuffle
        previous_ex_time = exec_time_of :faster_merge_e2210, for: big_input

        big_input = thousand_elements.shuffle
        improved_time = exec_time_of :merge_improvements_e2211, for: big_input

        assert_operator previous_ex_time, :>, improved_time
      end

      ## Start Utility methods

      # The standard merge sort implementation
      def standard_merge_sort(values, lo, hi)
        return values if hi <= lo
        mid = lo + (hi-lo)/2
        standard_merge_sort(values, lo, mid)
        standard_merge_sort(values, mid+1, hi)
        standard_merge(values, lo, mid, hi)
      end

      # The standard merge
      def standard_merge(input, lower_bound, mid, upper_bound)
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
        hundred_elements = (0..100).to_a
        cases = [{input: [0], expected: [0]},
                 {input: [0, 1], expected: [0, 1]},
                 {input: [0, 1, 2, 5, 7], expected: [0, 1, 2, 5, 7]},
                 {input: [1, 5, 2, 0], expected: [0, 1, 2, 5]},
                 {input: hundred_elements.shuffle, expected: hundred_elements}]


        cases.each { |test_case|
          # Act
          @aux = Array.new(test_case[:input].length)
          actual = standard_merge_sort test_case[:input], 0, test_case[:input].length - 1

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
          output = standard_merge(input, lo, mid, hi)

          # Assert
          assert_equal(expected_output, output)
        }
      end


      def exec_time_of(method_sym, input)
        target_method = @target.method(method_sym)
        time_block {
          target_method.call(input[:for])
        }
      end

      def check_faster_for_sorted_array
        thousand_elements = (0..100).to_a
        standard_time = time_block {
          @aux = Array.new(thousand_elements.length)
          standard_merge_sort thousand_elements, 0, thousand_elements.length - 1
        }

        faster_time = time_block {
          @target.merge_improvements_e2211 thousand_elements
        }

        assert_operator((standard_time/2), :>, faster_time)
      end

      # This is not an exercise, it helps test the execution time of faster than
      # standard mergesort algorithms
      def check_faster_than_standard(method_sym)
        thousand_elements = (0..100).to_a
        big_input = thousand_elements.shuffle
        standard_time = time_block {
          @aux = Array.new(big_input.length)
          standard_merge_sort big_input, 0, big_input.length - 1
        }

        big_input = thousand_elements.shuffle
        faster_time = exec_time_of(method_sym, for: big_input)
        # puts "assert_operator #{standard_time} > #{faster_time}. Improvement: #{(((standard_time/faster_time)-1)*100).ceil}%"
        assert_operator standard_time, :>, faster_time
      end

      ## End Utility Methods
    end
  end
end
