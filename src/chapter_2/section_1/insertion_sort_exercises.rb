#encoding: utf-8

module Chapter2
  module Section1
    class InsertionSortExercises
      def e2125_insertion_sort_no_swap(values)
        i = 1
        while i < values.length
          # store the values[i] value
          current = values[i]

          # instead of comparing values[j] < values[j-1], we compare against
          # the value of the element we are moving around, since we are just
          # going to overwrite the element at the jth position.
          j = i
          while j > 0 and current < values[j-1]
            # move the larger entries to the right
            values[j] = values[j-1]
            j-=1
          end
          # set the current element to the index of the last element to be
          # greater than itself.
          values[j] = current

          i+=1
        end

        values
      end
    end
  end
end
