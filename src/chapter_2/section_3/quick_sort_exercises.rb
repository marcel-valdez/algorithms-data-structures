# encoding: utf-8

module Chapter2
  module Section3
    class QuickSortExercises
      def median3_quicksort_e2318(input)
        quicksort_e2318(input, 0, input.length - 1)
        input
      end

      def quicksort_e2318(input, lo, hi)
        return if hi <= lo

        pivot = partition(input, lo, hi)

        quicksort_e2318(input, lo, pivot-1)
        quicksort_e2318(input, pivot+1, hi)
      end

      def partition(input, lo, hi)
        # handle the cases in which the partition is size 2
        if hi - lo == 1
          if input[lo] > input[hi] # items are order inverted
            input[hi], input[lo] = input[lo], input[hi] # swap them
          end

          return hi
        end

        # find 3-sample median
        forwards, backwards = lo, hi+1
        median = find_median3(hi, input, lo)
        
        while true
          forwards+=1
          until input[forwards] >= median or forwards == hi # until item belonging to right side found
            forwards+=1 # keep looking forwards
          end

          backwards-=1
          until input[backwards] <= median # until item belonging to left side found
            backwards-=1 # keep looking backwards
          end

          break if forwards >= backwards # stop if indexes collide

          input[backwards], input[forwards] = input[forwards], input[backwards] # swap items
        end

        input[lo], input[backwards] = input[backwards], input[lo]
        backwards
      end

      def find_median3(hi, input, lo)
        mid = lo + (hi-lo) >> 1 # middle
        median = input[mid]
        if input[lo] < input[hi]
          if median < input[lo] #  mid < lo < hi
            median = input[lo] # make lo our median
          else # lo < mid < hi
            input[mid], input[lo] = input[lo], input[mid] # make lo our median
          end
        elsif median < input[hi] # mid < hi < lo
          median = input[hi]
          input[hi], input[lo] = input[lo], input[hi] # make lo our median
        else # lo < mid < hi
          input[mid], input[lo] = input[lo], input[mid] # make lo our median
        end

        median
      end
    end
  end
end
