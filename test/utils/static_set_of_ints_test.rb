require_relative "../test_helper"
require_relative "../../src/utils/static_set_of_ints"
module Utils
  class StaticSetOfIntsTest < TestHelper
  	def initialize *arg
      super(*arg)
      @target= StaticSetOfInts.new [2,4,5,7,12]
    end

    test "It has API definition" do
      # Arrange
      api = [:contains?]
      non_api = [:array=]

      # Act
      target = StaticSetOfInts.new [2,4,5,7,12]

      # Assert
      api.each { |method_name|
        assert_respond_to target, method_name
      }

      non_api.each { |method_name|
        assert_not_respond_to target, method_name
      }
    end

    test "Test the contains method" do
      # Arrange

      # Act
      target = StaticSetOfInts.new [2,4,5,7,12]

      # Assert
      assert_true target.contains? 7
      assert_false target.contains? 3
    end
  end
end