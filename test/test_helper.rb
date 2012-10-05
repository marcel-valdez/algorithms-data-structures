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
# verify_cases sum, with: [params: [2, 2], expected: 4]
#   will call:
#   actual = @target.sum(2, 2)
#   assert_equals(2, expected)
# verify_cases average, with: [param: [2, 2], expected: 2]
#   actual = @target.average([2, 2])
#   assert_equals(2, expected)
  def verify_method (test_method, test_data)
    test_cases = test_data[:with]
    test_cases.each do |test_case|
      # Arrange
      input, expands = get_input(test_case)

      # Act & Assert
      if is_predicate? test_case
        predicate = test_case[:predicate]
        do_predicate_case(test_method, input, expands, &predicate)
      else
        expected = test_case[:expected]
        do_test_case(test_method, input, expected, expands)
      end
    end
  end

  def time_block
    start = Time.now
    yield
    finish = Time.now

    finish - start
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

  def get_input (test_case = {})
    keys = [:params, :param]

    found, key = test_case.find_any keys
    return found, key_expands?(key) unless found.nil?

    nil
  end

  def key_expands? (key)
    expanded_params = [:params]
    expanded_params.any? { |a_key| a_key.eql? key }
  end

  def is_predicate? (test_case)
    keys = [:predicate]
    found = test_case.find_any keys
    not found.nil?
  end
end