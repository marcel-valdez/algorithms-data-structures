# encoding: utf-8

require_relative '../test_helper'
require_relative '../../src/utils/stack'
require_relative 'utils_test_helper'

module Utils
  class StackTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= Stack.new
    end

    def test_api_definition
      # Arrange
      api = [:is_empty?, :size, :push, :pop, :peek]
      non_api = [:size=, :first=, :last=, :first, :last]

      # Act
      @target = Stack.new

      # Assert
      assert_api(api, non_api)
    end

    def test_starts_empty
      # Arrange
      # Act
      target = Stack.new

      # Assert
      assert_true target.is_empty?
    end

    def test_use_each_to_find
      # Arrange
      target = Stack.new
      i=2

      # Act
      target.push 1
      target.push 2

      # Assert
      target.each { |node_value|
        assert_equal i, node_value
        i-=1
      }
    end

    def test_add_first_node
      # Arrange
      target = Stack.new

      # Act
      target.push 1

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size
      assert_equal 1, target.peek

      sub_case 'Test if it can add a second node' do
        # Act (2nd)
        target.push 2

        # Assert
        assert_equal 2, target.size
        assert_false target.is_empty?
        assert_equal 2, target.peek

        sub_case 'Test if it can pop a node' do
          # Act (3rd)
          actual = target.pop

          # Assert
          assert_equal 1, target.size
          assert_equal 2, actual
          assert_equal 1, target.peek

          sub_case 'Test if can pop the last node' do
            # Act (4th)
            actual = target.pop

            # Assert
            assert_true target.is_empty?
            assert_equal 0, target.size
            assert_equal 1, actual
          end
        end
      end
    end
  end
end
