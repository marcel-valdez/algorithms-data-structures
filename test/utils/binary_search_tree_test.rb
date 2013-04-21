# encoding: utf-8

require_relative '../test_helper'
require_relative '../../src/utils/binary_search_tree'
require_relative 'utils_test_helper'

module Utils
  class BinarySearchTreeTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= nil
    end

    def test_api_definition
      # Arrange
      api = [
          :put,
          :get,
          :delete,
          :contains?,
          :is_empty?,
          :size,
          :keys,
          :min,
          :max,
          :floor,
          :ceiling,
          :select,
          :rank,
          :delete_min,
          :delete_max]
      non_api = [:size=, :is_empty=, :keys=, :root, :root=, :min=, :floor=]

      # Act
      @target = BinarySearchTree.new

      # Assert
      assert_api(api, non_api)
    end

    def test_it_starts_empty
      # Arrange
      # Act
      target = BinarySearchTree.new

      # Assert
      assert_true target.is_empty?
    end


    def test_it_enumerate_nodes
      # Arrange
      target = BinarySearchTree.new
      i=1

      # Act
      target.put 1, '1'
      target.put 2, '2'

      # Assert
      target.keys.each { |node_key|
        assert_equal i, node_key
        i+=1
      }
    end

    def test_it_gets_min
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, 1..5)
      expected_min = (1..5).min

      # Act
      min = target.min

      # Assert
      assert_equal(expected_min, min)
    end

    def test_it_gets_max
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, 1..5)
      expected_max = (1..5).max

      # Act
      max = target.max

      # Assert
      assert_equal(expected_max, max)
    end

    def test_it_gets_floor
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act/Assert
      verify_method :floor,
                    with: [[6, 5], [5, 5],
                           [0, nil], [9, 8]]
      # Clean
      @target = nil
    end

    def test_it_gets_ceiling
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act/Assert
      verify_method :ceiling,
                    with: [[6, 7], [5, 5],
                           [0, 1], [9, nil]]
      # Clean
      @target = nil
    end

    def test_it_selects_keys
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act/Assert
      verify_method :select,

                    with: [[0, 1], [6, nil], [-1, nil],
                           [5, 8], [3, 5], [2, 3]]
      # Clean
      @target = nil
    end

    def test_it_gets_rank
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act/Assert
      verify_method :rank,
                    with: [[1, 0], [6, 4], [-1, 0], [8, 5],
                           [5, 3], [3, 2], [9, 6]]
      # Clean
      @target = nil
    end

    def test_it_deletes_largest_key
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)
      expect_deleted = [8, 7, 5]

      # Act
      check_delete(expect_deleted, :delete_max, 6)

      # Clean
      @target = nil
    end

    def test_it_deletes_smallest_key
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)
      expect_deleted = [1, 2, 3]

      # Act
      check_delete(expect_deleted, :delete_min, 6)

      # Clean
      @target = nil
    end

    def test_it_deletes_key

      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :delete,
                    with: [
                        delete_expectation(1, 5),
                        delete_expectation(8, 5),
                        delete_expectation(3, 5)
                    ]
      # Clean
      @target = nil
    end

    def test_it_gets_key_range
      # Arrange
      keys = [3, 2, 1, 8, 7, 5]
      set_target_values(*keys)

      # Act
      verify_keys_range_behavior(keys)
      # Clean
      @target = nil
    end

    def test_it_gets_size_of_key_range
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :size,
                    with: [
                        {params: [1, 1], expect: 1},
                        {params: [8, 8], expect: 1},
                        {params: [1, 8], expect: 6},
                        {params: [2, 7], expect: 4},
                        {params: [3, 3], expect: 1},
                        {params: [0, 1], expect: 1},
                        {params: [8, 9], expect: 1},
                        {params: [0, 9], expect: 6}
                    ]
    end

    # This is a story def test_or the basic functionality of the BST
    def test_it_adds_first_node
      # Arrange
      target = BinarySearchTree.new

      # Act
      target.put 1, '1'

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size
      assert_true target.contains?(1)

      sub_case ' then test if it can add a second node' do
        # Act (2nd)
        target.put 2, '2'

        # Assert
        assert_equal 2, target.size
        assert_false target.is_empty?

        sub_case ' then test if it can get a node' do
          # Act (3rd)
          actual = target.get 2

          # Assert
          assert_equal 2, target.size
          assert_equal '2', actual
          assert_true target.contains?(2)

          sub_case ' then test if can delete a node' do
            # Act (4th)
            target.delete 2

            # Assert
            assert_equal 1, target.size
          end
        end
      end
    end

    def delete_expectation(param, size)
      {
          param: param,
          predicate: Proc.new {
            assert_equal size, @target.size
            assert_false @target.contains?(param)
            @target.put(param, param.to_s)
            true
          }
      }
    end

    def insert_values(target, range)
      range.each { |value| target.put(value, value.to_s) }
    end

    def set_target_values(*key_values)
      @target = BinarySearchTree.new
      insert_values(target, key_values)
    end

    def check_delete(expected_deleted, method_name, size)
      expected_deleted.each { |expected|
        verify_method method_name,
                      with: [{
                                 predicate: Proc.new {
                                   size -= 1
                                   @target.get(expected).nil? and @target.size == size
                                 }}]
      }
    end
  end
end