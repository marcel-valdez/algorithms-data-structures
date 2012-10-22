require_relative "../../utils/static_set_of_ints"
module Utils
	class StaticSetOfInts

		def find_bounds array, hi, lo, mid, value, type
			#didn't find the value
			if lo == hi && array[lo] != value
				return -1
			end
			
			#looking for the lowest index of the value
			if type == :LO
				if array[hi] == array[lo]
					return lo
				end
				
				if array[mid-1] == value
					hi = mid
				elsif array[mid] == value
					return mid
				else
					lo = mid+1
				end	
			end

			#looking for the highest index of the value
			if type == :HI
				if array[hi] == array[lo]
					return hi
				end

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
		def how_many value
			lo = 0
			hi = @array.length - 1
			mid = lo + (hi - lo) / 2
			
			#ordinary binary search
			#while both bounds hasn't reach each other
			while (lo <= hi) and @array[mid] != value
			 	#divide the range where the value could be
			 	mid = lo + (hi - lo) / 2
			 	if value < @array[mid] then hi = mid - 1
			 	elsif value > @array[mid] then lo = mid + 1
			 	end
			end

			#if didn't find the value with the binary search
			if @array[mid] != value
				return 0
			end

			hi_index = find_bounds @array, hi, lo, mid, value, :HI
			lo_index = find_bounds @array, hi, lo, mid, value, :LO

			if lo_index == -1
				lo_index = mid
			end
			if hi_index == -1
				hi_index = mid
			end
			return hi_index - lo_index + 1
		end
	end
end

module Chapter1
	module Section4
		class StaticSetOfIntsExercises
			def initialize values
				@staticSetOfInts = Utils::StaticSetOfInts.new values
			end
			
			def how_many_e1411 value
				return @staticSetOfInts.how_many value
			end
		end
	end
end