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
      api = [:put, :get, :delete, :contains, :is_empty?, :size, :keys]
      non_api = [:size=, :is_empty=, :keys=, :root, :root=]

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
      i=2

      # Act
      target.put 1, "1"
      target.put 2, "2"

      # Assert
      target.keys.each { |node_value|
        assert_equal i.to_s, node_value
        i+=1
      }
    end

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