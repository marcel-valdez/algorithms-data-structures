#encoding: utf-8

module Chapter2
  module Section2
    class MergeSortExercises
      # 2.2.10 Faster merge. Implement a version of mergesort that copies the
      # second half of the input array to the auxiliary array in -decreasing order- and then
      # does the merge back to the input array. This change allows you to remove
      # the code to test that each of the halves has been exhausted from the inner loop.
      def faster_merge_e2210(input)
        @aux = Array.new(input.length)
        faster_merge_sort(input, 0, input.length - 1)

        input
      end

      def faster_merge_sort(values, lo, hi)
        return values if hi <= lo

        mid = lo + (hi-lo)/2
        faster_merge_sort(values, lo, mid)
        faster_merge_sort(values, mid+1, hi)
        faster_merge(values, lo, mid, hi)
      end

      def faster_merge(input, lower_bound, mid, upper_bound)
        i = lower_bound
        # copy normally from lower_bound to mid
        until i == mid+1
          @aux[i] = input[i]
          i+=1
        end
        # copy backwards from mid+1 to upper_bound
        aux_i = mid+1
        i = upper_bound
        until i == mid
          @aux[aux_i] = input[i]
          aux_i += 1
          i -= 1
        end

        low_idx = lower_bound
        hi_idx = upper_bound
        i = lower_bound
        while i <= upper_bound
          # when low_idx is mid+1 then it will always enter here
          if @aux[hi_idx] < @aux[low_idx] # if right half element is lower
            input[i] = @aux[hi_idx]
            hi_idx -=1 # hi_idx is transversed backwards
          else # if left half element is lower
            input[i] = @aux[low_idx]
            low_idx+=1 # lo_idx is transversed normal
          end

          i+=1
        end

        input
      end

      # 2.2.11 Improvements. Implement the three improvements to mergesort described
      # in the Algorithms 4th ed book. These are:
      # 1) Add a cutoff for small subarrays. Use insertion sort for these.
      # 2) Test whether the array is already in order. if a[mid] <= a[mid+1] don't merge.
      # 3) Avoid the auxiliary copy, by switching arguments in the recursive code.
      #    Two invocations to sort:
      #       1) input array as its parameter, and put the output in the aux array
      #       2) aux array as its parameter, and put sorted output in the input array
      def merge_improvements_e2211(values)
        @aux = Array.new(values.length)
        @aux.each_index { |i| values[i] = @aux[i] } if improved_merge_sort(values, 0, values.length - 1)

        values
      end

      def improved_merge_sort(input, lo, hi)
        if hi <= lo
          return false
        end

        if hi - lo <= 15 # is array is small, use insertion sort
          insertion_sort(input, lo, hi)
          return false
        end

        mid = lo + (hi-lo)/2
        aux_as_input = improved_merge_sort(input, lo, mid) # sort left half
        aux_as_input &= improved_merge_sort(input, mid+1, hi) # sort right half
        if aux_as_input # if aux is the source for merging
          if @aux[mid] <= @aux[mid+1] # if already sorted
            copy @aux, input, lo, hi-lo+1 # do straight copy
          else # if not already sorted
            improved_merge(@aux, input, lo, mid, hi) # merge from @aux to input
          end
          false
        else # if input is the source for merging
          if input[mid] <= input[mid+1] # if already sorted
            copy input, @aux, lo, hi-lo+1 # do straight copy
          else # if not already sorted
            improved_merge(input, @aux, lo, mid, hi) # merge from input to @aux
          end
          true
        end
      end

      def copy(src, dst, start, count)
        i = start
        while i < start + count
          dst[i] = src[i]
          i+=1
        end
      end

      def improved_merge(input, output, lower_bound, mid, upper_bound)
        #
        # removed need to copy array
        #
        low_idx, hi_idx = lower_bound, mid+1

        i = lower_bound
        until i > upper_bound
          if low_idx > mid
            output[i] = input[hi_idx]
            hi_idx+=1
          elsif hi_idx > upper_bound
            output[i] = input[low_idx]
            low_idx+=1
          elsif input[hi_idx] < input[low_idx]
            output[i] = input[hi_idx]
            hi_idx+=1
          else
            output[i] = input[low_idx]
            low_idx+=1
          end

          i+=1
        end
      end

      def insertion_sort(values, lo, hi)
        i = lo
        while i <= hi
          current = values[i]

          j = i
          while j > lo and current < values[j-1]
            values[j] = values[j-1]
            j-=1
          end

          values[j] = current
          i+= 1
        end
      end
    end
  end
end
