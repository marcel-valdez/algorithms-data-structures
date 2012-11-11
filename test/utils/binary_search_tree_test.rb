# encoding: utf-8

require_relative "../test_helper"
require_relative "../../src/utils/binary_search_tree"
require_relative "utils_test_helper"

module Utils
  class BinarySearchTreeTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= nil
    end

    test "if it has correct API definition" do
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

    test "if it starts empty" do
      # Arrange

      # Act
      target = BinarySearchTree.new

      # Assert
      assert_true target.is_empty?
    end


    test "if it can enumerate nodes" do
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

    test "if it can get min" do
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, 1..5)
      expected_min = (1..5).min

      # Act
      min = target.min

      # Assert
      assert_equal(expected_min, min)
    end

    test "if it can get max" do
      # Arrange
      target = BinarySearchTree.new
      insert_values(target, 1..5)
      expected_max = (1..5).max

      # Act
      max = target.max

      # Assert
      assert_equal(expected_max, max)
    end

    test "if it can get floor" do
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :floor,
                    # Assert
                    with: [{param: 6, expect: 5},
                           {param: 5, expect: 5},
                           {param: 0, expect: nil},
                           {param: 9, expect: 8}]

      # Clean
      @target = nil
    end

    test "if it can get ceiling" do
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :ceiling,
                    # Assert
                    with: [{param: 6, expect: 7},
                           {param: 5, expect: 5},
                           {param: 0, expect: 1},
                           {param: 9, expect: nil}]

      # Clean
      @target = nil
    end

    test "if it can select keys" do
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :select,
                    # Assert
                    with: [
                        {param: 0, expect: 1},
                        {param: 6, expect: nil},
                        {param: -1, expect: nil},
                        {param: 5, expect: 8},
                        {param: 3, expect: 5},
                        {param: 2, expect: 3}
                    ]

      # Clean
      @target = nil
    end

    test "if it can get the rank" do
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :rank,
                    # Assert
                    with: [
                        {param: 1, expect: 0},
                        {param: 6, expect: 4},
                        {param: -1, expect: 0},
                        {param: 8, expect: 5},
                        {param: 5, expect: 3},
                        {param: 3, expect: 2},
                        {param: 9, expect: 6},
                    ]

      # Clean
      @target = nil
    end

    test "if it can delete the largest key" do
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :delete_max,
                    with: [{predicate: Proc.new { @target.get(8).nil? and @target.size == 5 }},
                           {predicate: Proc.new { @target.get(7).nil? and @target.size == 4 }},
                           {predicate: Proc.new { @target.get(5).nil? and @target.size == 3 }}]
      # Clean
      @target = nil
    end

    test "if it can delete the smallest key" do
      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :delete_min,
                    with: [{predicate: Proc.new { @target.get(1).nil? and @target.size == 5 }},
                           {predicate: Proc.new { @target.get(2).nil? and @target.size == 4 }},
                           {predicate: Proc.new { @target.get(3).nil? and @target.size == 3 }}]
      # Clean
      @target = nil
    end

    test "if it can delete a key" do

      # Arrange
      set_target_values(3, 2, 1, 8, 7, 5)

      # Act
      verify_method :delete,
                    with: [
                        {
                            param: 1,
                            predicate: Proc.new {
                              assert_equal 5, @target.size
                              assert_false @target.contains?(1)
                              @target.put(1, "1")
                              true
                            }
                        },
                        {
                            param: 8,
                            predicate: Proc.new {
                              assert_equal 5, @target.size
                              assert_false @target.contains?(8)
                              @target.put(8, "8")
                              true
                            }
                        },
                        {
                            param: 3,
                            predicate: Proc.new {
                              assert_equal 5, @target.size
                              assert_false @target.contains?(3)
                              @target.put(3, "3")
                              true
                            }
                        }]
      # Clean
      @target = nil
    end

    test "if it can get a range of keys" do
      # Arrange
      keys = [3, 2, 1, 8, 7, 5]
      set_target_values(*keys)

      # Act
      verify_keys_range_behavior(keys)
      # Clean
      @target = nil
    end

    test "if it can get the size of a range of keys" do
      keys = [3, 2, 1, 8, 7, 5]
      set_target_values(*keys)

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

    # This is a story test for the basic functionality of the BST
    test "if it can add first node" do
      # Arrange
      target = BinarySearchTree.new

      # Act
      target.put 1, "1"

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size
      assert_true target.contains?(1)

      sub_case " then test if it can add a second node" do
        # Act (2nd)
        target.put 2, "2"

        # Assert
        assert_equal 2, target.size
        assert_false target.is_empty?

        sub_case " then test if it can get a node" do
          # Act (3rd)
          actual = target.get 2

          # Assert
          assert_equal 2, target.size
          assert_equal "2", actual
          assert_true target.contains?(2)

          sub_case " then test if can delete a node" do
            # Act (4th)
            target.delete 2

            # Assert
            assert_equal 1, target.size
          end
        end
      end
    end

    def insert_values(target, range)
      range.each { |value| target.put(value, value.to_s) }
    end

    def set_target_values(*key_values)
      @target = BinarySearchTree.new
      insert_values(target, key_values)
    end
  end
end