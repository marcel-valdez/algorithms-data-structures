module Utils
	class StaticSetOfIntegers
		def initialize(values)
      @array = values
      @array = @array.sort
    end

		def contains?(value)
      #binary search
      lo = 0
      hi = @array.length - 1
      #while both bounds hasn't reach each other
      while lo <= hi
        #divide the range where the value could be
        mid = lo + (hi - lo) / 2
        if value < @array[mid] then
          hi = mid - 1
        elsif value > @array[mid] then
          lo = mid + 1
        else
          return true
        end
      end

      false
    end

	end
end