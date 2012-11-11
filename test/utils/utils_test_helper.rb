module Utils
  module UtilsTestHelper

    # asserts that the @target has (or not) a given api
    # @param [Symbol[]] api
    # @param [Symbol[]] non_api
    def assert_api(api, non_api)
      api.each { |method_name|
        assert_respond_to @target, method_name
      }

      non_api.each { |method_name|
        assert_not_respond_to @target, method_name
      }
    end
  end
end