module Chapter1
  module Section5
    class LSDExercises

      def initialize
        @alphabet_size = 0b100000000
        @letter_and = 0b11111111
        @letter_bits = 8
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
        size = values.length
        aux = Array.new(size, 0)
        total_lsd_passes = 2
        current_lsd_pass =  total_lsd_passes - 1
        while current_lsd_pass >= 0
          count = Array.new(@alphabet_size+1, 0)
          bit_shift = @letter_bits * (total_lsd_passes - current_lsd_pass - 1)
          i = 0
          while i < size
            # Obtains the key of the 8-bit number after shifting 'bit_shift' bits
            idx = ((values[i] >> bit_shift) & @letter_and) + 1
            count[idx]+=1
            i+=1
          end

          # Set key occurrence-based indexing, for ordering on next loop
          r = 0
          while r < @alphabet_size
            count[r+1] += count[r]
            r+=1
          end

          i = 0

          # Order numbers based on the occurrence count of their key
          while i < size
            # Obains the key of the 8-bit number after shifting 'bit_shift' bits
            idx = (values[i] >> bit_shift) & @letter_and

            aux[count[idx]] = values[i]
            count[idx]+=1

            i+= 1
          end

          # Copy back values
          i = 0
          while i < size
            values[i] = aux[i]
            i+= 1
          end

          current_lsd_pass-=1
        end

        # Insertion sort will be extremely fast because the numbers are partially ordered
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
