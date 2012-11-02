# encoding: utf-8

require_relative "../test_helper"
require_relative "../../src/utils/binary_search_tree"

module Utils
  class BinarySearchTreeTest < TestHelper

    def initialize(*arg)
      super(*arg)
      @target= BinarySearchTree.new
    end

    test "It has correct API definition" do
      # Arrange
      api = [
          :put,
          :get,
          :delete,
          :contains,
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
      target = BinarySearchTree.new

      # Assert

      api.each { |method_name|
        assert_respond_to target, method_name
      }

      non_api.each { |method_name|
        assert_not_respond_to target, method_name
      }
    end

    def insert_values(target, range)
      range.each { |value| target.put(value, value.to_s) }
    end

    test "Test it can get min" do
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, 1..5)
      expected_min = (1..5).min

      # Act
      min = target.min

      # Assert
      assert_equal(expected_min, min)
    end

    test "Test it can get max" do
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, 1..5)
      expected_max = (1..5).max

      # Act
      max = target.max

      # Assert
      assert_equal(expected_max, max)
    end

    def floor_test_helper(expected_floor, param, target)
      floor = target.floor(param)

      # Assert
      assert_equal(expected_floor, floor)
    end

    #
    #
    test "Test it can get floor" do
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, [1, 2, 3, 5, 7, 8])
      params = [{param: 6, expect: 5},
                {param: 5, expect: 5},
                {param: 0, expect: 1},
                {param: 9, expect: 8}]

      params.each { |pair|
        param = pair[:param]
        expected_floor = pair[:expect]

        # Act
        floor_test_helper(expected_floor, param, target)
      }

    end
    #
    #test "Test it can get ceiling" do
    #  assert_fail_assertion()
    #end
    #
    #test "Test it can select keys" do
    #  assert_fail_assertion()
    #end
    #
    #test "Test it can get the rank" do
    #  assert_fail_assertion()
    #end
    #
    #test "Test it can delete the largest key" do
    #  assert_fail_assertion()
    #end
    #
    #test "Test it can delete the smallest key" do
    #  assert_fail_assertion()
    #end

    test "Test it starts empty" do
      # Arrange

      # Act
      target = BinarySearchTree.new

      # Assert
      assert_true target.is_empty?
    end


    test "Test each to find node " do
      # Arrange
      target = BinarySearchTree.new
      i=1

      # Act
      target.put 1, "1"
      target.put 2, "2"

      # Assert
      target.keys.each { |node_key|
        assert_equal i, node_key
        i+=1
      }
    end

    # This is a story test for the basic functionality of the BST
    test "Test if it can add first node" do
      # Arrange
      target = BinarySearchTree.new

      # Act
      target.put 1, "1"

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size

      sub_case "Test if it can add a second node" do
        # Act (2nd)
        target.put 2, "2"

        # Assert
        assert_equal 2, target.size
        assert_false target.is_empty?

        sub_case "Test if it can get a node" do
          # Act (3rd)
          actual = target.get 2

          # Assert
          assert_equal 2, target.size
          assert_equal "2", actual

          sub_case "Test if can delete a node" do
            # Act (4th)
            target.delete 2

            # Assert
            assert_equal 1, target.size
          end
        end
      end
    end
  end
end