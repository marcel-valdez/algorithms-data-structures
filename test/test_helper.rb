class TestHelper < Test::Unit::TestCase
  attr :target
# @param [Symbol] test_method
# @param [Enumerable] data
# Example:
# verify_method sum, with: [params: [2, 2], expected: 4]
#   will call:
#   actual = @target.sum(2, 2)
#   assert_equals(2, expected)
# verify_method average, with: [param: [2, 2], expected: 2]
#   actual = @target.average([2, 2])
#   assert_equals(2, expected)
  def verify_method test_method, data
    test_cases = data[:with]
    test_cases.each do |test_case|

      # Arrange
      expected = test_case[:expected]

      # Act
      if not test_case[:param].nil?
        input = test_case[:param]
        actual = @target.send(test_method, input)
      elsif not test_case[:params].nil?
        input = test_case[:params]
        actual = @target.send(test_method, *input)
      end

      # Assert
      if test_case[:precision].nil?
        assert_equal(expected, actual, "Call to #{test_method.to_s} with parameters #{input.to_s}, failed:")
      else
        assert_in_delta(expected, actual, test_case[:precision], "Call to #{test_method.to_s} with parameters "+
                                                                 "#{input.to_s} and precision #{test_case[:precision]}"+
                                                                 ", failed:")
      end
    end
  end

  def time_block
    start = Time.now
    yield
    finish = Time.now

    finish - start
  end
end