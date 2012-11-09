require_relative "../test_helper"
require_relative "../../src/utils/bag"

module Utils
  class BagTest < TestHelper

  	def initialize(*arg)
      super(*arg)
      @target= Bag.new
    end

    test "if it has API definition" do
      # Arrange
      api = [:is_empty?, :size, :insert]
      non_api = [:size=, :first=, :first]

      # Act
      target = Bag.new

      # Assert

      api.each { |method_name|
        assert_respond_to target, method_name
      }

      non_api.each { |method_name|
        assert_not_respond_to target, method_name
      }
    end

    test "if it starts empty" do
      # Arrange

      # Act
      target = Bag.new

      # Assert
      assert_true target.is_empty?
    end

    test "if it can add first node" do
      # Arrange
      target = Bag.new

      # Act
      target.insert 1

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size

      sub_case "test if it can add a second node" do
        # Act (2nd)
        target.insert 2

        # Assert
        assert_equal 2, target.size
        assert_false target.is_empty?
      end

      sub_case "test if it can traverse the nodes" do
      	# Arrange
      	i = 2

        # Act (3th)
       	target.each {|item|
       		# Assert
       		assert_equal i, item
       		i-=1
       	}

      end
    end

  end
end