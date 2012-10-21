require_relative "../../utils/bag"

module Chapter1
	module Section3
		class BagExercises
			def initialize
				@bag = Utils::Bag.new
			end

      def random_bag_e1334 (values)
        length = values.length

        for i in 0...length
          random_index = Random.rand(length)
          value_at_random_index = values[random_index]
          values[random_index] = values[i]
          values[i] = value_at_random_index
        end

        values
      end

			#Exercise 1.3.34
			# Write a method that returns the items of a bag in a random order
			def random_bag_e1334_v1 (values)
				length = values.length
				random_length = length

				@bag_results = Array.new(length)
				random_results = Array.new(length)

				#insert values in bag
				values.each { |item| @bag.insert(item) }
				#retrieve values from bag into an array
				@bag.each_with_index { |item,index| @bag_results[index] = item }
				
				#puts "Length: #{length-1}"
				for i in 0..length-1
					#Random generates a number between 0 and less than the argument passed
					index = Random.rand(random_length)
					
					#Take the value of the random index and put it in the randomized array
					random_results[i] = view_array(index)
					random_length -= 1
				end

				#clean the global variables
				@bag = @bag_results = nil
				return random_results
			end

			#view array hides the nil values from the array
			#simulates that the array has shrank
			#index is a random index within the *view* of the array
			def view_array (index)
				#virtual_iter is a virtual index, only counts non-null values
				virtual_iter = 0
				#loop the bag_results elements
				for i in 0..@bag_results.length-1
					#only counts elements not already obtained
					unless @bag_results[i].nil?
						#if the virtual counter is equal to the required index
						#the value on the real index is returned
						if index==virtual_iter
							result = @bag_results[i]
							#set to null in order to ignore it in future invocations
							@bag_results[i] = nil
							return result
						end
						#if the virtual counter is different to the required index
						#the value of the virtual counter is increased
						virtual_iter += 1
					end
				end
				return nil
			end
		end
	end
end
