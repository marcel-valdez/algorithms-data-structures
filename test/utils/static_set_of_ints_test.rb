require_relative "../test_helper"
require_relative "../../src/utils/static_set_of_ints"
require_relative "utils_test_helper"

module Utils
  class StaticSetOfIntsTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= StaticSetOfIntegers.new [2, 4, 5, 7, 12]
    end

    test "if it has API definition" do
      # Arrange
      api = [:contains?]
      non_api = [:array=]

      # Act
      @target = StaticSetOfIntegers.new [2, 4, 5, 7, 12]

      # Assert
      assert_api(api, non_api)
    end

    test "if it has a working contains? method" do
      # Arrange

      # Act
      target = StaticSetOfIntegers.new [2, 4, 5, 7, 12]

      # Assert
      assert_true target.contains? 7
      assert_false target.contains? 3
    end
  end
end