module Utils	
	class Node
	 	attr_accessor :value, :next

	 	def initialize(value)
	 		@value = value
	 		@next = nil
		end
	 
	end

	class List

		def initialize(node)
	 		@count = 1
	 		@fptr = node
	 		@cur_ptr = @fptr

		end #constructor ends

	 	def add(node)
	 		@count += 1
	 		@cur_ptr.next=node
	 		@cur_ptr = node
	 	end #add() ends

	 	def remove()

	 	end #remove ends

	 	def print()
		 	if defined?(@fptr)
		 		puts "Found #{@count} items..."
		 		@traverser = @fptr

		 		while @traverser.next != nil
		 			puts @traverser.value
		 			@traverser = @traverser.next

		 		end #while ends

		 		puts @traverser.value

	 		else
	 			puts("Empty list")

	 		end #if-else ends
		end #print() ends
	end #class List end
end
