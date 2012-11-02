require_relative "../test_helper"
require_relative "../../src/utils/symbol_table"

module Utils
	class SymbolTableTest < TestHelper
		def initialize *arg
			super(*arg)
			@target= SymbolTable.new
		end

		test "It has API definition" do
			# Arrange
			api = [:put, :get, :delete, :contains?, :is_empty?, :size, :min, :max, :floor, :ceiling, 
				:rank, :select, :delete_min, :delete_max, :keys_in, :size_in, :keys]
			non_api = [:size=, :first=, :last=, :min=, :max=, :first, :last]

			# Act
			target = SymbolTable.new

			# Assert
			api.each { |method_name|
			assert_respond_to target, method_name
			}

			non_api.each { |method_name|
			assert_not_respond_to target, method_name
			}
	    end

	    test "Test it starts empty" do
			# Arrange

			# Act
			target = SymbolTable.new

			# Assert
			assert_true target.is_empty?
	    end

	    test "Test contains?, is_empty?, size and repeated key" do
			# Arrange
			target = SymbolTable.new

			# Act
			target.put 1, "A"
			target.put 6, "A"
			target.put 4, "C"

			# Assert
			assert_equal 3, target.size
			assert_true target.contains? 6
			assert_true target.contains? 1
			assert_true target.contains? 4
			assert_false target.is_empty?

			# Act 2
			target.put 1, "R"
			assert_equal "R", target.get(1)
	    end

	    test "Test add paired keys and retrieve them" do
			# Arrange
			target = SymbolTable.new

			# Act
			target.put 1, "A"
			target.put 6, "A"
			target.put 4, "C"
			target.put 2, "DB"
			target.put 12, "R"

			# Assert get
			assert_equal "A", target.get(1)
			assert_equal "C", target.get(4)
			assert_equal "R", target.get(12)
			assert_equal nil, target.get(13)

			# Assert min and max
			assert_equal 1, target.min
			assert_equal 12, target.max

			# Assert floor and ceiling
			assert_equal 2, target.floor(3)
			assert_equal 4, target.ceiling(4)

			# Assert rank (number of keys less than the key)
			assert_equal 3, target.rank(6)
			#the key 5 doesn't exists
			assert_equal nil, target.rank(5)  

			# Assert select
			assert_equal 6, target.select(3)
			assert_equal 12, target.select(4)
			assert_equal nil, target.select(7)

			# Assert keys_in
			# s_table = SymbolTable.new
			# s_table.put(4,"C")
			# assert_equal s_table, target.keys_in(3,5)
			# assert_equal nil, target.keys_in(7,10)

			# Assert size_in
			assert_equal 2, target.size_in(1,3)
			assert_equal 0, target.size_in(7,10)
	    end

	    test "Test delete values" do
	    	# Arrange
			target = SymbolTable.new

			# Act
			target.put 1, "A"
			target.put 6, "A"
			target.put 4, "C"
			target.put 2, "DB"
			target.put 12, "R"
			target.put 8, "T"
			target.put 7, "P"

			target.delete 4
			target.delete_min
			target.delete_max

			# Assert delete, delete_min, delete_max
			assert_equal nil, target.get(4)
			assert_equal nil, target.get(1)
			assert_equal nil, target.get(12)
	    end
	end
end
