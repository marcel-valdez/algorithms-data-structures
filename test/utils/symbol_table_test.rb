require_relative "../test_helper"
require_relative "../../src/utils/symbol_table"

module Utils
  class SymbolTableTest < TestHelper
    def initialize(*arg)
      super(*arg)
      @target= SymbolTable.new
    end

    test "if it has API definition" do
      # Arrange
      api = [:put, :get, :delete, :contains?, :is_empty?, :size, :min, :max, :floor, :ceiling,
             :rank, :select, :delete_min, :delete_max, :keys_in, :size_in, :keys]
      non_api = [:size=, :first=, :last=, :min=, :max=, :first, :last]

      # Act
      instance_methods = SymbolTable.public_instance_methods(false)

      # Assert
      api.each { |method_name|
        assert_include instance_methods, method_name
      }

      non_api.each { |method_name|
        assert_not_include instance_methods, method_name
      }
    end

    test "if it starts empty" do
      # Arrange
      # Act
      target = SymbolTable.new

      # Assert
      assert_true target.is_empty?
    end

    test "if it knows when: contains?, is_empty?, size and repeated key" do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => "A", 6 => "A", 4 => "C")

      # Act
      size = target.size

      # Assert
      assert_equal 3, size

      # Act
      empty = target.is_empty?

      # Assert
      assert_false empty

      # Assert
      assert_true target.contains? 6
      assert_true target.contains? 1
      assert_true target.contains? 4
    end

    test "if it can overwrite a key" do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => "A")
      previous_value = target.get(1)

      # Act
      target.put(1, "Z")
      actual_value = target.get(1)

      # Assert
      assert_not_equal previous_value, actual_value
      assert_equal "Z", actual_value
    end

    test "if it can add paired keys and retrieve them" do
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

      # a key with rank 5 does not exist
      assert_nil target.rank(5)

      # Assert select
      assert_equal 6, target.select(3)
      assert_equal 12, target.select(4)
      assert_nil target.select(7)

      # Assert keys_in
      # s_table = SymbolTable.new
      # s_table.put(4,"C")
      # assert_equal s_table, target.keys_in(3,5)
      # assert_equal nil, target.keys_in(7,10)

      # Assert size_in
      assert_equal 2, target.size_in(1, 3)
      assert_equal 0, target.size_in(7, 10)
    end

    test "if it can delete values" do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => "A", 6 => "A", 4 => "C", 2 => "DB", 12 => "R", 8 => "T", 7 => "P")

      # Act
      target.delete 4
      target.delete_min
      target.delete_max

      # Assert delete, delete_min, delete_max
      assert_nil target.get(4)
      assert_nil target.get(1)
      assert_nil target.get(12)
    end

    def set_pairs(target, pairs)
      pairs.each { |key, value| target.put(key, value) }
    end
  end
end
