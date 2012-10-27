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
        merge_sort(input, 0, input.length - 1)

        input
      end

      def merge_sort(values, lo, hi)
        return values if hi <= lo

        mid = lo + (hi-lo)/2
        merge_sort(values, lo, mid)
        merge_sort(values, mid+1, hi)
        merge(values, lo, mid, hi)
      end

      def merge(input, lower_bound, mid, upper_bound)

        i = lower_bound
        until i == mid+1
          @aux[i] = input[i]
          i+=1
        end

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
            if @aux[hi_idx] < @aux[low_idx] # compare elements
              input[i] = @aux[hi_idx]
              hi_idx -=1
            else # if @aux[low_idx] < @aux[hi_dx]
              input[i] = @aux[low_idx]
              low_idx+=1
            end

          i+=1
        end

        input
      end
    end
  end
end
