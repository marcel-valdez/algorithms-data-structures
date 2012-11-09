require_relative "../../test_helper"
require_relative "../../../src/chapter_1/section_1/exercises"

module Chapter1
  module Section1
    class Exercises_test < TestHelper

      attr_accessor :rec_calls

      # Called before every test method runs. Can be used
      # to set up fixture information.
      def initialize(*args)
        super(*args)
        @target = Exercises.new
      end

      # 1.1.3 Write a function that takes a three integer string and
      # returns true if all are equal, and false otherwise
      def test_exercise_113
        verify_method :exercise_113,
                      :with => [{param: "1 2 3", expect: false},
                                {param: "1 1 1", expect: true}]
      end

      # 1.1.5 Write a function exercise_115 that returns true if the
      # Double numbers x and y are both strictly between 0 and 1,
      # false otherwise.
      def test_exercise_115
        verify_method :exercise_115,
                      :with => [{param: [0.8, 0.8], expect: true},
                                {param: [0.1, 0.1], expect: true},
                                {param: [0.9, 0.9], expect: true},
                                {param: [1, 1], expect: false},
                                {param: [0, 0], expect: false}]
      end

      # 1.1.9 Write a method that returns a string with the binary representation of N
      # Suppose that the input number is always 0 or greater.
      def test_exercise_119
        verify_method :exercise_119,
                      :with => [{param: 1, expect: "1"},
                                {param: 2, expect: "10"},
                                {param: 3, expect: "11"},
                                {param: 8, expect: "1000"},
                                {param: 11, expect: "1011"}]
      end

      # 1.1.11 Write a method exercise_1111 that prints a Matrix with a header with the index of the columns
      # and the index of the row, example:
      # input: [3, 4]  output: " 12\n" +
      #        [5, 6]          "134\n" +
      #                        "256\n"
      def test_exercise_1111
        verify_method :exercise_1111,
                      :with => [{param: [[true]], expect: " 1\n1*\n"},
                                {param: [[false]], expect: " 1\n1 \n"},
                                {param: [[true, false]], expect: " 12\n1* \n"},
                                {param: [[true, false], [true, false]], expect: " 12\n1* \n2* \n"}]
      end

      # 1.1.13 Write a method exercise_1113 that receives a matrix NxM and transposes rows into columns MxN
      def test_exercise_1113
        verify_method :exercise_1113,
                      :with => [{param: [[0]], expect: [[0]]},
                                {param: [[0, 1]],
                                 expect: [[0],
                                          [1]]},
                                {param: [[0, 1],
                                         [2, 3]],
                                 expect: [[0, 2],
                                          [1, 3]]}]

      end

      # 1.1.14 Write a method exercise_1114 that calculates log2 of N, without using Math.log2
      def test_exercise_1114
        verify_method :exercise_1114,
                      :with => [{param: 2, expect: Math.log2(2).truncate},
                                {param: 3, expect: Math.log2(3).truncate},
                                {param: 9, expect: Math.log2(9).truncate},
                                {param: 90, expect: Math.log2(90).truncate}]
      end

      # 1.1.15 Write a method exercise_1115 that count the times a number appears in an array and
      # stores this count in another array, example: [0, 1, 1] result: [1, 2]
      def test_exercise_1115
        verify_method :exercise_1115,
                      :with => [{params: [[0], 1], expect: [1]},
                                {params: [[0], 2], expect: [1, 0]},
                                {params: [[1, 1], 2], expect: [0, 2]},
                                {params: [[1, 2, 3, 3, 3, 4], 5], expect: [0, 1, 1, 3, 1]}]
      end

      def recursive_fibonacci (n)
        return 0 if n == 0
        return 1 if n == 1

        recursive_fibonacci(n - 1) + recursive_fibonacci(n -2)
      end

      def calc_all_fibonacci (n)
        result = Array.new n + 1
        (0..n).each { |i| result[i] = recursive_fibonacci(i) }

        result
      end

      # 1.1.19 Write a method exercise_1119 with better performance (5x faster) than
      # calc_all_fibonacci above, to calculate all fibonacci numbers between 0 to N and store
      # them in an array and return it as the result.
      def test_exercise_1119
        expected_result = nil
        time_span = time_block { expected_result = calc_all_fibonacci 20 }
        verify_method :exercise_1119,
                      :with => {param: 20, expect: expected_result}

        actual_time_span = time_block { @target.exercise_1119 20 }

        assert_true actual_time_span < time_span / 5
      end

      # 1.1.20 Write a method exercise_1120 that calculates the value ln(N!)
      def test_exercise_1120
        verify_method :exercise_1120,
                      :with => [{param: 1, expect: Math.log(1).truncate},
                                {param: 2, expect: Math.log(2).truncate},
                                {param: 4, expect: Math.log(4 * 3 * 2).truncate},
                                {param: 3, expect: Math.log(3 * 2).truncate}]
      end

      # 1.1.22 Write a method exercise_1122 that is a version of BinarySearch that uses the
      # recursive rank() function (as per the book definition) and traces the method calls.
      # Return a string that each time the recursive method is called, append the arguments
      # lo and hi, indented by the depth of the recursion.
      def test_exercise_1122
        verify_method :exercise_1122,
                      :with => [{
                                    params: [0, [0, 1, 2, 3, 4, 5]],
                                    expect: "lo: 0, hi: 5\n\tlo: 0, hi: 1\n"
                                },
                                {
                                    params: [5, [0, 1, 2, 3, 4, 5]],
                                    expect: "lo: 0, hi: 5\n\tlo: 3, hi: 5\n\t\tlo: 5, hi: 5\n"
                                }]
      end

      # 1.1.24 Write a method exercise_1124 that calculates the greatest common divisor, using
      # Euclid's algorithm and use it to calculate the greatest common divisor for
      # 1111111 and 1234567
      def test_exercise_1124
        verify_method :exercise_1124,
                      :with => [{params: [1111111, 1234567], expect: 1},
                                {params: [33 * 7, 33 * 23], expect: 33},
                                {params: [41 * 13, 41 * 29], expect: 41}]

      end

      def binomial(n, k, p)
        @rec_calls += 1

        return 1.0 if n == 0 and k == 0
        return 0.0 if n < 0 or k < 0

        left = ((1 - p) * binomial(n-1, k, p))
        right = (p * binomial(n-1, k-1, p))

        left + right
      end

      # 1.1.27 Create a method exercise_1127 that estimates the number of recursive
      # calls of the function binomial(n,k,p) written above.
      def test_exercise_1127
        @rec_calls = 0
        binomial(10, 4, 0.25)
        predicate = Proc.new { |actual|
          Math.log10(actual).truncate == Math.log10(@rec_calls).truncate
        }

        params = [10, 4]
        verify_method :exercise_1127,
                      :with => [{params: params, predicate: predicate}]
      end

      # 1.1.28 Write a function exercise_1128 that removes duplicates from an array
      def test_exercise_1128
        verify_method :exercise_1128,
                      :with => [{param: [0, 0, 1, 2, 3, 3], expect: [0, 1, 2, 3]},
                                {param: [0, 1, 2, 3], expect: [0, 1, 2, 3]},
                                {param: [0, 0], expect: [0]},
                                {param: [0], expect: [0]}]
      end
    end
  end
end
