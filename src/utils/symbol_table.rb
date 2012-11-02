module Utils
	class KeyValue_Pair
		attr_accessor :key, :value, :next
		def initialize (key, value, next_node)
			@key = key
			@value = value
		    @next = next_node
		end
	end

	class SymbolTable
		include Enumerable
		attr_reader :size, :min, :max

		def initialize
		    @first = nil
		    @last = nil
		    @min = nil
		    @max = nil
		    @size = 0
		end

		def put (key, value)
			@key_value_pair = KeyValue_Pair.new(key, value, @first)
			@first = @key_value_pair
			if @size == 0
				@last = @key_value_pair
				@min = key
		    	@max = key
		    else
		    	if key < @min
		    		@min = key
		    	end
		    	if key > @max
		    		@max = key
		    	end
			end
			@size += 1
		end

		def each
			current = @first
			until current.nil?
				yield current.key, current.value
				current = current.next
			end
		end

		def get (key)
			current = @first
			until current.nil?
				if current.key == key
					return current.value
				end
				current = current.next
			end
			return nil
		end

		def contains? (key)
			current = @first
			until current.nil?
				if current.key == key
					return true
				end
				current = current.next
			end
			return false
		end

		def floor (key)
			current = @first
			closest_key = nil
			until current.nil?
				if current.key == key
					closest_key = current.key
					return closest_key
				elsif current.key < key and ((!closest_key.nil? and current.key > closest_key) or closest_key.nil?)
					closest_key = current.key
				end
				current = current.next
			end
			return closest_key
		end

		def ceiling (key)
			current = @first
			closest_key = nil
			until current.nil?
				if current.key == key
					closest_key = current.key
					return closest_key
				elsif current.key > key and ((!closest_key.nil? and current.key < closest_key) or closest_key.nil?)
					closest_key = current.key
				end
				current = current.next
			end
			return closest_key
		end

		def rank (key)			
			if contains?(key)
				number_rank = 0
				current = @first
				until current.nil?
					if current.key < key
						number_rank += 1
					end
					current = current.next
				end
				return number_rank
			else
				return nil
			end
		end

		def select (num_rank)
			current = @first
			until current.nil?
				if num_rank == rank(current.key)
					return current.key
				end
				current = current.next
			end
			return nil
		end

		# TO DO: The next attribute hasn't yet been assigned
		def keys_in (lo, hi)
			s_table = SymbolTable.new
			current = @first
			until current.nil?
				if current.key >= lo or current.key <= hi
					s_table.put(current.key, current.value, nil)
				end
				current = current.next
			end
			s_table = s_table.sort { |key, value| key }
		end

		def size_in (lo, hi)
			cont = 0
			current = @first
			until current.nil?
				if current.key >= lo and current.key <= hi
					cont += 1
				end
				current = current.next
			end
			return cont
		end

		def keys
			return self.sort { |key, value| key }
		end

		def is_empty?
			size == 0
		end

		def delete (key)
			current = @first
			until current.nil?
				if !current.next.nil? and current.next.key == key
					if @last == current.next
						current.next = nil
						@last = current
					else
						current.next = current.next.next
					end
					if @min == key
						find_new_min
					end
					if @max == key
						find_new_max
					end
				end
				current = current.next
			end
			return nil
		end

		def delete_min
			temp_min = @min
			delete(@min)
			find_new_min
			if temp_min == @max
				find_new_max
			end
		end

		def delete_max
			temp_max = @max
			delete(@max)
			find_new_max
			if temp_max == @min
				find_new_min
			end
		end

		private
		def find_new_min
			current = @first
			@min = current.key
			until current.nil?
				if current.key < @min
					@min = current.key
				end
				current = current.next
			end
		end
		def find_new_max
			current = @first
			@max = current.key
			until current.nil?
				if current.key > @max
					@max = current.key
				end
				current = current.next
			end
		end
	end
end