#encoding: utf-8

require_relative '../../utils/static_set_of_ints'
module Utils
  class StaticSetOfIntegers

    # assumes the value received will always be in the ordered array
    def find_bounds(array, hi, lo, mid, value, type)
      # found a hi or lo index that matches the other bound
      if array[hi] == array[lo]
        # if we're looking for the higher bound, return hi, otherwise return lo
        return type == :HI ? hi : lo
      end

      # looking for the lowest index of the value
      if type == :LO
        if array[mid-1] == value
          hi = mid
        elsif array[mid] == value
          return mid
        else
          lo = mid+1
        end
      end

      # looking for the highest index of the value
      if type == :HI
        if array[mid+1] == value
          lo = mid+1
        elsif array[mid] == value
          return mid
        else
          hi = mid-1
        end
      end

      mid = lo + (hi - lo) / 2
      find_bounds array, hi, lo, mid, value, type
    end


    # Add a new method to the class.
    # 1.4.11 Add an instance method howMany() to StaticSETofInts (page 99)
    # that finds the number of occurrences of a given key
    # in time proportional to log N in the worst case.
    def how_many(value)
      lo = 0
      hi = @array.length - 1
      mid = lo + (hi - lo) / 2

      # ordinary binary search
      # while both bounds hasn't reach each other
      while (lo <= hi) and @array[mid] != value
        # divide the range where the value could be
        mid = lo + (hi - lo) / 2
        if value < @array[mid] then
          hi = mid - 1
        elsif value > @array[mid] then
          lo = mid + 1
        end
      end

      # if didn't find the value with the binary search
      if @array[mid] != value
        return 0
      end

      hi_index = find_bounds @array, hi, lo, mid, value, :HI
      lo_index = find_bounds @array, hi, lo, mid, value, :LO

      hi_index - lo_index + 1
    end
  end
end

module Chapter1
  module Section4
    class StaticSetOfIntsExercises
      def initialize(values)
        @integer_set = Utils::StaticSetOfIntegers.new values
      end

      def e1411_how_many(value)
        @integer_set.how_many value
      end
    end
  end
end
