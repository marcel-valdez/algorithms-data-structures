# encoding: utf-8

require_relative '../test_helper'
require_relative '../../src/utils/min_priority_queue'
require_relative 'utils_test_helper'
require_relative 'priority_queue_test_helper'

module Utils
  # This class contains the tests that describe the Min Priority Queue
  class MinPriorityQueueTest < TestHelper
    include UtilsTestHelper
    include PriorityQueueTestHelper

    def initialize(*arg)
      super(*arg)
      @target= nil
    end

    test 'if it has the correct API' do
      # Arrange
      api = [
          :delete_min,
          :insert,
          :is_empty?,
          :each,
          :min,
          :size]
      non_api = [:size=, :is_empty=, :keys=, :min=, :size=]

      # Act
      @target = create_target()

      # Assert
      assert_api(api, non_api)
    end

    test "if it can insert an element and tell it's size" do
      check_insert_increases_size
    end

    test 'if it can get the min element' do
      # Arrange
      keys = [5, 1, 0, 6, 3, 9, 4, 8, 7]

      # Act/Assert
      check_get_key(0, :min, keys)
    end

    test 'if it can delete the smallest key' do
      # Arrange
      keys = (0..9).to_a

      # Act/Assert
      check_can_delete(:delete_min, 0, keys)
    end

    test 'if it can delete the smallest key until empty' do
      # Arrange
      keys = (0..9).to_a

      # Act/Assert
      check_delete_until_empty(:delete_min, :min, keys)
    end

    test 'if it can enumerate all keys in ascending order' do
      # Arrange
      keys = (0..9).to_a

      # Act/Assert
      check_key_enumeration(keys)
    end

    def create_target
      MinPriorityQueue.new
    end
  end
end