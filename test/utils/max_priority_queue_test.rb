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
      non_api = [:size=, :is_empty=, :keys=, :root, :root=, :max=, :size=]

      # Act
      @target = MaxPriorityQueue.new

      # Assert
      assert_api(api, non_api)
    end

    test "if it can insert an element" do
      # Arrange
      @target = MaxPriorityQueue.new

      # Act
      @target.insert(1)

      # Assert
      assert_equal 1, @target.size

      # Clean
      @target = nil
    end

    # TODO: Integration test
    test "if it can attend a client story" do

    end

  end
end