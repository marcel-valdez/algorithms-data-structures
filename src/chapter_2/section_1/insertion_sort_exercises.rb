#encoding: utf-8

module Chapter2
  module Section1
    class InsertionSortExercises
      def insertion_sort_no_exchanges_e2125(values)
        # puts "Running insertion sort optimization with: #{values.inspect}"
        for i in 1...values.length
          # store the values[i] value
          current = values[i]          

          # instead of comparing values[j] < values[j-1], we compare against
          # the value of the element we are moving around, since we are just
          # going to overwrite the element at the jth position.
          j = i
          while j > 0 and current < values[j-1]
            # puts "Moving values[#{j-1}](#{values[j-1]}) to values[#{j}]"
            # move the larger entries to the right
            values[j] = values[j-1]
            j-=1
          end          
          # set the current element to the index of the last element to be
          # greater than itself.
          values[j] = current
          # puts "Iter: #{i}, values: #{values.inspect}"
        end

        values
      end
    end
  end
end
