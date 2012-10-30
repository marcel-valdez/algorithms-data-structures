module Utils
	class Bag
		include Enumerable
		attr_reader :size

		def initialize
		    @first = nil
		    @size = 0
		end

		def is_empty?
			@size == 0
		end

		def insert (value)
			old_first = @first
			new_node = NodeOfBag.new(value, old_first)
			@size += 1
			@first = new_node
		end

		def each
			current = @first
			until current.nil?
				yield current.value
				current = current.next
			end
		end

		private
		attr_accessor :first
		attr_writer :size

		class NodeOfBag
			attr_accessor :value, :next

			def initialize (value, next_node)
				@value     = value
			    @next   = next_node
			end
		end
	end
end