#encoding: utf-8

require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_3/quick_sort_exercises"
require_relative "../test_sort_helper"

module Chapter2
  module Section3
    class QuickSortExercises_test < TestHelper

      include Chapter2::TestSortHelper

      def initialize(*args)
        super(*args)
        @target = QuickSortExercises.new
      end


      # 2.3.18 Median-of-3 partitioning. Add median-of-3 partitioning to quicksort.
      #        This implies sampling the first 3 items and choosing the median-sample as
      #        the partitioning key.
      #        Note: The test will only check that it sorts correctly and is faster
      #              than merge sort. We trust you will really implement the technique.
      # Assumptions: Assume the input array is shuffled
      def test_median3_quicksort_e2318

        check_sort_correctness :median3_quicksort_e2318

        thousand_items = (0..1000).to_a
        @aux = Array.new(thousand_items.length)
        merge_sort_proc = Proc.new {
          standard_merge_sort(thousand_items.shuffle, 0, thousand_items.length - 1)
        }

        median3_sort_proc = create_proc :median3_quicksort_e2318, thousand_items.shuffle
        # Check that its faster than the standard merge sort
        assert_faster_proc(median3_sort_proc, merge_sort_proc)
      end


      # 2.3.22 Fast 3-way partitioning (J. Bentley and D. McIlroy) Implement an entropy-optimal
      #        sort based on keeping item's with equal keys ad both the left and right ends of
      #        the subarray.
      #
      #        Maintain indices p and q such that a[lo..p-1] and a[q+1..hi] are  all equal to a[lo],
      #        and index i such that q[p..i-1] are all less than a[lo], and index j such that a[j+1..q]
      #        are all greater than a[lo].
      #
      #        Add to the inner partitioning loop code to swap a[i] with a[p] (and increment p)
      #        if it is equal to v and to swap a[j] with a[q] (and decrement q) if it is equal to v
      #        before the usual comparisons of a[i] and a[j] with v.
      #
      #        After the partitioning loop has terminated, add code to swap the items with equal
      #        keys into position.
      #
      #        Note: This code implements the code given in the text, in the sense that it does
      #              extra swaps for keys equal to the partitioning item's key, while the code in
      #              the text does extra swaps for keys that are -not- equal to the partitioning
      #              item's key
      # Assumptions: Assume the input array is shuffled

      # 2.3.23 Super quick sort. Add to your implementation from exercise 2.3.22 code to use the
      #        Tukey ninther to compute the partitioning item-choose three sets of three items,
      #        take the median of each, then use the median of the three medians as the partitioning
      #        item. Also, add a cutoff to insertion sort for small subarrays.
    end
  end
end
