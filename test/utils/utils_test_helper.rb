# encoding: utf-8

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

    # this method verifies the behavior of the keys method
    # for a search table (i.e. binary tree or symbol table)
    def verify_keys_range_behavior(keys)
      verify_method :keys,
                    with: [
                        {
                            params: [1, 1],
                            predicate: Proc.new { |result|
                              assert_equal 1, result.size
                              assert_equal 1, result.dequeue

                              true
                            }
                        },
                        {
                            params: [8, 8],
                            predicate: Proc.new { |result|
                              assert_equal 1, result.size
                              assert_equal 8, result.dequeue

                              true
                            }
                        },
                        {
                            params: [1, 8],
                            predicate: Proc.new { |result|
                              assert_equal 6, result.size

                              keys.sort.each { |key|
                                assert_equal key, result.dequeue
                              }

                              true
                            }
                        },
                        {
                            params: [0, 9],
                            predicate: Proc.new { |result|
                              assert_equal 6, result.size

                              keys.sort.each { |key|
                                assert_equal key, result.dequeue
                              }

                              true
                            }
                        },
                        {
                            params: [2, 7],
                            predicate: Proc.new { |result|
                              assert_equal 4, result.size

                              [2, 3, 5, 7].each { |key|
                                assert_equal key, result.dequeue
                              }

                              true
                            }
                        },
                        {
                            params: [3, 3],
                            predicate: Proc.new { |result|
                              assert_equal 1, result.size
                              assert_equal 3, result.dequeue

                              true
                            }
                        }
                    ]
    end
  end
end