# encoding: utf-8

require 'test/unit'

class Hash
  # @param [Array] keys to look for
  # @return [Object, Object] The found object and the key found, nil otherwise
  def find_any (keys)
    keys.each { |key|
      unless self[key].nil?
        return self[key], key
      end
    }

    nil
  end
end

#noinspection RubyResolve
class TestHelper < Test::Unit::TestCase
  attr_accessor :target

# @param [Symbol] test_method
# @param [Enumerable] test_data
# Example:
# verify_cases :sum, with: [params: [2, 2], expect: 4]
#   will call:
#   actual = @target.send(:sum, 2, 2)
#   assert_equals(2, expected)
# verify_cases :average, with: [param: [2, 2], expect: 4]
#   actual = @target.send(:average, [2, 2])
#   assert_equals(4, expected)
# verify_cases :sum, [[2,2], 4]
#   actual = @target.send(:sum, [2,2])
#   assert_equals(4, expected)
  def verify_method (test_method, test_data)
    test_cases = test_data[:with]
    # If we received with: { param: x, expect: y }, turn it into a single element array
    test_cases = [test_cases] if test_cases.is_a? Hash

    test_cases.each do |test_case|
      # Arrange
      input, expands = get_input(test_case)

      # Act & Assert
      if is_predicate? test_case
        predicate = test_case[:predicate]
        do_predicate_case(test_method, input, expands, &predicate)
      else
        expected = nil
        expected = test_case[:expect] if test_case.instance_of? Hash
        expected = test_case[1] if test_case.instance_of? Array
        do_test_case(test_method, input, expected, expands)
      end
    end
  end

  # @return [Object]
  def time_block
    start = Time.now
    yield
    finish = Time.now

    finish - start
  end

  def sub_case (test_name = '')
    begin
      yield
    rescue Test::Unit::AssertionFailedError => error
      new_msg = "sub test: #{test_name}: \n#{error.message}"
      new_error = Test::Unit::AssertionFailedError.new(new_msg,
                                                       {user_message: error.user_message,
                                                        inspected_actual: error.inspected_actual,
                                                        actual: error.actual,
                                                        inspected_expected: error.inspected_expected,
                                                        expect: error.expected})

      new_error.set_backtrace error.backtrace

      raise new_error
    end
  end

  private

  def assert_expectation(actual, expected, input = nil, test_method = nil)
    assert_equal(expected, actual, get_error_msg(input, test_method))
  end

  def do_predicate_case(test_method, input, expand, &predicate)
    actual = call_target(expand, input, test_method)
    assert_true predicate.call(actual), get_error_msg(input, test_method)
  end

  def do_test_case(test_method, input, expected, expand)
    actual = call_target(expand, input, test_method)
    assert_expectation(actual, expected, input, test_method)
  end

  #noinspection RubyResolve,RubyResolve
  def call_target(expand, input, test_method)

    if input.nil?
      actual = @target.send(test_method)
    else
      if expand
        actual = @target.send(test_method, *input)
      else
        actual = @target.send(test_method, input)
      end
    end

    actual
  end

  def get_error_msg(input, test_method)
    "Call to #{test_method.to_s} with parameters #{input.to_s}, failed:" unless input.nil? or test_method.nil?
  end

  def get_input (test_case)
    raise 'Test definition error: nil test case provided.' if test_case.nil?

    keys = [:params, :param]

    if test_case.instance_of? Hash
      found, key = test_case.find_any keys
      return found, key_expands?(key)
    elsif test_case.instance_of? Array
      return test_case[0]
    end

    nil
  end

  def key_expands? (key)
    expanded_params = [:params]
    expanded_params.any? { |a_key| a_key.eql? key }
  end

  def is_predicate? (test_case)
    keys = [:predicate]
    if test_case.instance_of? Hash
      found = test_case.find_any keys
      return !found.nil?
    elsif test_case.instance_of? Array
      test_case[1].instance_of? Proc
    end

    false
  end

  # Example usage: simulate_complexity(str.length) { |n| n**2}
  # simulates time for an algorithm with n^2 complexity
  # @return [Float] time in seconds of simulation
  # @param [Numeric] n size of data
  def simulate_complexity (n)
    loops = yield n
    time_block {
      i = 0
      (1..loops).each { |x|
        # Perform a 'real' operation, not just a sum or concatenation
        i += Float(i)/x
      }
    }
  end
end