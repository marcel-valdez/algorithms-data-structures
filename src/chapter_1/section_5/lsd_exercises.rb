module Chapter1
  module Section5
    class LSDExercises

      def initialize
        @r = 0b100000000
      end

      # 5.1.15 Sublinear sort. Develop a sort implementation for int values
      # that makes two passes through the array to do an LSD sort on the leading
      # 16 bits of the keys, then does an insertion sort.
      # Hint: 2 passes of 8 bits each? I think SO.
      # Note: The test will check that numbers get correctly ordered
      #       and that it outperforms a quicksort algorithm.
      # Good luck ;)
      # 8-bit 'alphabet', Two passes with keys from:
      # The first on the 0-7 bits of the number
      # Then on the 8-15 bits of the number
      def sublinear_sort_e5115 values
        # puts "values: #{values.inspect}"
        size = values.length
        aux = Array.new(size, 0)
        letter_bits = 8
        letter_count = 2
        letter_position =  letter_count - 1
        letter_and = 0b11111111
        while letter_position >= 0
          count = Array.new(@r+1, 0)
          bit_shift = letter_bits * (letter_count - letter_position - 1)
          i = 0
          while i < size
            # Obains the key of the 8-bit number after shifting 'bit_shift' bits
            idx = ((values[i] >> bit_shift) & letter_and) + 1
            # puts "accessing index: #{idx}, bit_position: #{letter_position}, values[#{i}]: #{values[i]}"
            count[idx]+=1
            i+=1
          end

          # puts "bit: #{bit_shift} occurrences: #{count.inspect}"
          r = 0
          while r < @r
            count[r+1] += count[r]
            r+=1
          end

          i = 0
          # puts "bit_position: #{bit_shift}"
          while i < size
            # Obains the key of the 8-bit number after shifting 'bit_shift' bits
            idx = (values[i] >> bit_shift) & letter_and

            # puts "\tidx: #{idx}"
            # puts "\tcount[#{idx}]: #{count[idx]}"
            # puts "\tvalues[#{i}]: #{values[i]}"
            # puts "\tprevious: aux[#{count[idx]}]: #{aux[count[idx]]}"
            # puts "\tvalues[#{idx}]: #{values[idx]}"

            aux[count[idx]] = values[i]

            # puts "\taux[#{count[idx]}]: #{values[i]}"
            # puts ""
            count[idx]+=1

            i+= 1
          end

          i = 0
          while i < size
            values[i] = aux[i]
            i+= 1
          end

          # puts "aux@bit: #{bit_shift}: #{aux.inspect}"
          letter_position-=1
        end

        insertion_sort values

        values
      end

      def insertion_sort values
        i = 0
        while i < values.length
          j = i
          while j > 0 and values[j] < values[j-1]
            temp = values[j-1]
            values[j-1] = values[j]
            values[j] = temp
            j -= 1
          end

          i += 1
        end
      end

    end
  end
end
