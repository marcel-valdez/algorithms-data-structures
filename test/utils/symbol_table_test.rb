require_relative '../test_helper'
require_relative '../../src/utils/symbol_table'
require_relative 'utils_test_helper'

module Utils
  class SymbolTableTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= SymbolTable.new
    end

    test 'if it has API definition' do
      # Arrange
      api = [:put, :get, :delete, :contains?, :is_empty?, :size, :min, :max, :floor, :ceiling,
             :rank, :select, :delete_min, :delete_max, :keys]
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

    test 'if it starts empty' do
      # Arrange
      # Act
      target = SymbolTable.new

      # Assert
      assert_true target.is_empty?
    end

    test 'if it knows when: contains?, is_empty?, size and repeated key' do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => 'A', 6 => 'A', 4 => 'C')

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

    test 'if it can overwrite a key' do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => 'A')
      previous_value = target.get(1)

      # Act
      target.put(1, 'Z')
      actual_value = target.get(1)

      # Assert
      assert_not_equal previous_value, actual_value
      assert_equal 'Z', actual_value
      assert_equal 1, target.size
    end

    test 'if setting a key to nil value, deletes it' do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => 'A')
      # Legacy code pre-condition
      assert_equal 1, target.size
      assert_not_nil target.get(1)

      # Act
      target.put(1, nil)
      actual_value = target.get(1)

      # Assert
      assert_nil actual_value
      assert_equal 0, target.size
    end

    test 'if it can add paired keys and retrieve them' do
      # Arrange
      target = SymbolTable.new

      # Act
      target.put 1, 'A'
      target.put 6, 'A'
      target.put 4, 'C'
      target.put 2, 'DB'
      target.put 12, 'R'

      # Assert get
      assert_equal 'A', target.get(1)
      assert_equal 'C', target.get(4)
      assert_equal 'R', target.get(12)
      assert_equal nil, target.get(13)

      # Assert min and max
      assert_equal 1, target.min
      assert_equal 12, target.max

      # Assert floor and ceiling
      assert_equal 2, target.floor(3)
      assert_equal 4, target.ceiling(4)

      # Assert rank (number of keys less than the key)
      assert_equal 3, target.rank(6)

      # the key 5 has not been added, but still
      # should return its rank
      assert_equal 3, target.rank(5)

      # Assert select
      assert_equal 6, target.select(3)
      assert_equal 12, target.select(4)
      assert_nil target.select(7)

      # Assert size
      assert_equal 2, target.size(1, 3)
      assert_equal 0, target.size(7, 10)
    end

    test 'if it can delete values' do
      # Arrange
      target = SymbolTable.new
      set_pairs(target, 1 => 'A', 6 => 'A', 4 => 'C', 2 => 'DB', 12 => 'R', 8 => 'T', 7 => 'P')

      # Legacy code pre-condition
      assert_not_nil target.get(4)
      # Act
      target.delete 4
      # Assert delete
      assert_nil target.get(4)

      # Legacy code pre-condition
      assert_not_nil target.get(1)
      # Act
      target.delete_min
      # Assert delete_min
      assert_nil target.get(1)

      # Legacy code pre-condition
      assert_not_nil target.get(12)
      # Act
      target.delete_max
      # Assert delete_max
      assert_nil target.get(12)
    end

    test 'if it can get a range of keys' do
      # Arrange
      keys = [3, 2, 1, 8, 7, 5]
      @target = SymbolTable.new

      set_pairs(@target, 3 => '3', 2 => '2', 1 => '1', 8 => '8', 7 => '7', 5 => '5')

      # Act
      verify_keys_range_behavior keys

      # Clean
      @target = nil
    end

    def set_pairs(target, pairs)
      pairs.each { |key, value| target.put(key, value) }
    end
  end
end
