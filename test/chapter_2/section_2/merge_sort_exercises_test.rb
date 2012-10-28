#encoding: utf-8

require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_2/merge_sort_exercises"
require_relative "../test_sort_helper"

module Chapter2
  module Section2
    class MergeSortExercises_test < TestHelper

      include Chapter2::TestSortHelper

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
        check_sort_correctness(:faster_merge_e2210)

        check_faster_than_standard(:faster_merge_e2210)
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
        check_sort_correctness :merge_improvements_e2211

        #       2) That it executes at least twice as fast for a sorted array
        #          than the standard merge sort.
        check_faster_for_sorted_array()

        #       3) That it runs faster than the standard merge sort
        check_faster_than_standard(:merge_improvements_e2211)

        #       4) That it runs faster than the implementation of exercise 2.2.10.
        #          So you need to solve exercise 2.2.10 first. ;)
        assert_faster_method :merge_improvements_e2211, :faster_merge_e2210
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
