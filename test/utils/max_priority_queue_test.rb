# encoding: utf-8

require_relative "../test_helper"
require_relative "../../src/utils/max_priority_queue"
require_relative "utils_test_helper"

module Utils
  # This class contains the tests that describe the Max Priority Queue
  class MaxPriorityQueueTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= nil
    end

    test "if it has the correct API" do
      # Arrange
      api = [
          :delete_max,
          :insert,
          :is_empty?,
          :each,
          :max,
          :size]
      non_api = [:size=, :is_empty=, :keys=, :max=, :size=]

      # Act
      @target = MaxPriorityQueue.new

      # Assert
      assert_api(api, non_api)
    end

    test "if it can insert an element and tell it's size" do
      # Arrange
      @target = MaxPriorityQueue.new

      # Act
      @target.insert(1)

      # Assert
      assert_equal 1, @target.size

      # Clean
      @target = nil
    end

    test "if it can get the max element" do
      # Arrange
      keys = [5, 1, 0, 6, 3, 9, 4, 8, 7]
      @target = MaxPriorityQueue.new

      # Act
      keys.each { |key| @target.insert key }

      # Assert
      assert_equal keys.length, @target.size
      assert_equal 9, @target.max

      # Clean
      @target = nil
    end

    test "if it can delete the largest key" do
      # Arrange
      keys = (0...9).to_a
      @target = setup_heap(keys.shuffle)

      # Act
      actual = @target.delete_max

      # Assert
      assert_equal keys.max, actual
      assert_equal (keys.length - 1), @target.size

      # Clear
      @target = nil
    end

    test "if it can delete the largest key until empty" do
      # Arrange
      keys = (0...9).to_a
      @target = setup_heap(keys.shuffle)

      # Act
      until @target.is_empty? do
        actual = @target.delete_max

        # Assert
        assert_equal keys.max, actual
        keys.delete_at(keys.length - 1)
      end

      # Clean
      @target = nil
    end

    test "if it can enumerate all keys in descending order" do
      # Arrange
      keys = (0...9).to_a.reverse
      @target = setup_heap(keys.shuffle)

      # Act
      i = 0
      @target.each { |key|
        # Assert
        assert_equal keys[i], key
        i += 1
      }

      assert_equal i, keys.length
      # each should not change the size
      assert_equal keys.length, @target.size

      # Clean
      @target = nil
    end

    def setup_heap(*keys)
      target = MaxPriorityQueue.new
      keys.flatten!
      keys.each { |key| target.insert key }

      target
    end
  end
end