require_relative "../test_helper"
require_relative "../../src/utils/queue"

module Utils
  class QueueTest < TestHelper
    def initialize(*arg)
      super(*arg)
      @target= Queue.new
    end

    test "It has API definition" do
      # Arrange
      api = [:is_empty?, :size, :queue, :dequeue]
      non_api = [:size=, :first=, :last=, :first, :last]

      # Act
      target = Queue.new

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
      target = Queue.new

      # Assert
      assert_true target.is_empty?
    end

    test "Test each to find node " do

      target = Queue.new

      target.queue 1
      target.queue 2
      i=1
      target.each { |node|
        assert_equal i, node
        i+=1
      }
    end

    test "Test if it can add first node" do
      # Arrange
      target = Queue.new

      # Act
      target.queue 1

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size

      sub_case "Test if it can add a second node" do
        # Act (2nd)
        target.queue 2

        # Assert
        assert_equal 2, target.size

        sub_case "Test if it can pop a node" do
          # Act (3rd)
          actual = target.dequeue

          # Assert
          assert_equal 1, target.size
          assert_false target.is_empty?
          assert_not_nil actual
          assert_equal 1, actual

          sub_case "Test if can pop the last node" do
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
