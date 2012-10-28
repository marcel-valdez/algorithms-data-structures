#encoding: utf-8

module Chapter2
  module Section3
    class QuickSortExercises
      def median3_quicksort_e2318(input)
        puts "@"*20 + "\nmedian3_quicksort_e2318(#{input})"
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
        puts "-"*10 +"\npartition(#{input}, #{lo}, #{hi})"
        # handle the cases in which the partition is empty, size 1 or size 2
        if hi - lo == 1
          if input[lo] > input[hi]
            puts "partition.swapping: input[#{lo}]:#{input[lo]}, input[#{hi}]:#{input[hi]}"
            input[hi], input[lo] = input[lo], input[hi]
          end

          puts "\tpartition.result: #{input}"
          return hi
        end

        # find 3 sample median
        mid = lo + (hi-lo)/2
        median = input[mid]
        forwards, backwards = lo, hi+1
        median_idx = lo
        if input[lo] < input[hi]
          if median < input[lo] #  mid < lo < hi
            median = input[lo]
          end
        elsif median < input[hi] # mid < hi < lo
          median = input[hi]
          median_idx = hi
        else # lo < mid < hi

        end

        puts "\tpartition.median:#{median}, median_idx:#{median_idx}"
        while true
          forwards+=1
          until input[forwards] >= median or forwards == hi
            forwards+=1
          end # until an item not belonging in left side is found

          backwards-=1
          until input[backwards] <= median or backwards == lo
            backwards-=1
          end # until an item not belonging in right side is found

          break if forwards >= backwards # stop if indexes collide

          input[backwards], input[forwards] = input[forwards], input[backwards] # swap items
        end

        input[median_idx], input[backwards] = input[backwards], input[median_idx]
        puts "\tpartition.result: #{input}"
        backwards
      end
    end
  end
end
