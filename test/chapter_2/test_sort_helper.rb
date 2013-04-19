# encoding: utf-8
module Chapter2
  module TestSortHelper
    def check_sort_correctness(method_sym)
      numbers = (0..20).to_a
      verify_method method_sym,
                    :with => [
                        {param: [0], expect: [0]},
                        {param: [0, 1], expect: [0, 1]},
                        {param: [1, 0], expect: [0, 1]},
                        {param: [1, 2, 0], expect: [0, 1, 2]},
                        {param: [1, 5, 2, 0], expect: [0, 1, 2, 5]},
                        {param: [1, 5, 2, 7, 0], expect: [0, 1, 2, 5, 7]},
                        {param: [0, 1, 2, 5, 7], expect: [0, 1, 2, 5, 7]},
                        {param: [0, 1, 2, 5, 7, 3, 9, 8, 6, 4], expect: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]},
                        {param: numbers.shuffle, expect: numbers}
                    ]
    end

    # @param [Symbol] faster Symbol of the method that should be faster
    # @param [Symbol] slower Symbol of the method that should be slower
    def assert_faster_method(faster, slower, size = nil)
      size = 1000 if size.nil?
      input = (0..size).to_a
      lesser_proc = create_proc(faster, input)
      greater_proc = create_proc(slower, input)

      assert_faster_proc(lesser_proc, greater_proc)
    end

    # @param [Proc] faster Proc that should be faster
    # @param [Proc] slower Proc that should be slower
    def assert_faster_proc(faster, slower)
      lesser_time = time_block { faster.() }
      greater_time = time_block { slower.() }

      # When coverage is being calculated, the calculation times
      # get screwed up due to instrumentation.
      if ENV['TASK'].nil? or not ENV['TASK'].include? 'COVERAGE'
        assert_operator lesser_time, :<, greater_time
      end
    end

    def create_proc(method_name, input)
      param = input.shuffle
      method = @target.method(method_name)
      Proc.new { method.call(param) }
    end

    # The standard merge sort implementation
    def standard_merge_sort(values, lo, hi)
      return values if hi <= lo
      mid = lo + (hi-lo)/2
      standard_merge_sort(values, lo, mid)
      standard_merge_sort(values, mid+1, hi)
      standard_merge(values, lo, mid, hi)
    end

    # The standard merge
    def standard_merge(input, lower_bound, mid, upper_bound)
      low_idx, hi_idx = lower_bound, mid+1

      input.each_with_index { |number, idx| @aux[idx] = number }

      i = lower_bound
      until i > upper_bound
        if low_idx > mid
          input[i] = @aux[hi_idx]
          hi_idx+=1
        elsif hi_idx > upper_bound
          input[i] = @aux[low_idx]
          low_idx+=1
        elsif @aux[hi_idx] < @aux[low_idx]
          input[i] = @aux[hi_idx]
          hi_idx+=1
        else
          input[i] = @aux[low_idx]
          low_idx+=1
        end

        i+=1
      end

      input
    end

    # This is not an exercise, its a test for the standard merge sort implementation
    def test_merge_sort_helper
      # Arrange
      hundred_elements = (0..100).to_a
      cases = [{input: [0], expected: [0]},
               {input: [0, 1], expected: [0, 1]},
               {input: [0, 1, 2, 5, 7], expected: [0, 1, 2, 5, 7]},
               {input: [1, 5, 2, 0], expected: [0, 1, 2, 5]},
               {input: hundred_elements.shuffle, expected: hundred_elements}]


      cases.each { |test_case|
        # Act
        @aux = Array.new(test_case[:input].length)
        actual = standard_merge_sort test_case[:input], 0, test_case[:input].length - 1

        # Assert
        assert_equal test_case[:expected], actual
      }
    end

    # This is not an exercise, it is a test for the merge method
    # used to help test the merge_sort standard implementation
    def test_merge
      # Arrange
      cases = [{input: [0, 3, 2, 1, 4], expected: [0, 1, 3, 2, 4]}]
      cases.each { |test_case|
        input = test_case[:input]
        mid = input[input.length/2]
        lo = 0
        hi = input.length - 1
        expected_output = test_case[:expected]
        @aux = Array.new(input.length)

        # Act
        output = standard_merge(input, lo, mid, hi)

        # Assert
        assert_equal(expected_output, output)
      }
    end

    def exec_time_of(method_sym, input)
      target_method = @target.method(method_sym)
      time_block {
        target_method.call(input[:for])
      }
    end
  end
end