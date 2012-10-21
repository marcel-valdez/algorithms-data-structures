# encoding: utf-8

require_relative "../../utils/point2d"
require_relative "../../utils/number_utils"
require_relative "../../utils/linkedlist"

module Chapter1
  module Section3
    class LinkedListExercises

		def initialize
		   
		end

      	# Write a method delete() that takes an int argument k and deletes the kth 
      	# element in a linked list, if it exists.
      	# Assume input is always a string
     	# Examples:
		def delete_e31(nodo,input)

			while nodo.next != nil
					if nodo.value == input
						nodo.value = nodo.next.value 
						nodo.next = nodo.next.next 
					else 
				 		nodo = nodo.next
					end
			end #while ends
		 end

		#Write a method find() that takes a linked list and a string key as 
		#arguments and returns true if some node in the list has key as its item field, false otherwise.
      	# Assume input is always a string
		def find_e32(nodo,input)
			while nodo.next != nil
				if nodo.value == input
					return true
				end
				nodo = nodo.next
			end
			return false
		end
    end
  end
end
