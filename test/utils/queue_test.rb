require_relative '../test_helper'
require_relative '../../src/utils/queue'
require_relative 'utils_test_helper'

module Utils
  class QueueTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= Queue.new
    end

    def test_api_definition
      # Arrange
      api = [:is_empty?, :size, :queue, :dequeue]
      non_api = [:size=, :first=, :last=, :first, :last]

      # Act
      @target = Queue.new

      # Assert
      assert_api(api, non_api)
    end

    def test_starts_empty
      # Arrange
      # Act
      target = Queue.new

      # Assert
      assert_true target.is_empty?
    end

    def test_use_each_to_find
      target = Queue.new

      target.queue 1
      target.queue 2
      i=1
      target.each { |node|
        assert_equal i, node
        i+=1
      }
    end

    def test_add_first_node
      # Arrange
      target = Queue.new

      # Act
      target.queue 1

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size

      sub_case 'test if it can add a second node' do
        # Act (2nd)
        target.queue 2

        # Assert
        assert_equal 2, target.size

        sub_case 'test if it can pop a node' do
          # Act (3rd)
          actual = target.dequeue

          # Assert
          assert_equal 1, target.size
          assert_false target.is_empty?
          assert_not_nil actual
          assert_equal 1, actual

          sub_case 'test if can pop the last node' do
            # Act (4th)
            actual = target.dequeue

            assert_equal 0, target.size
            assert_true target.is_empty?
            assert_not_nil actual
            assert_equal 2, actual
          end
        end
      end
    end
  end
end
