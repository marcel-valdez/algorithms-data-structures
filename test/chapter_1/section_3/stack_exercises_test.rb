# encoding: utf-8

require "test/unit"
require_relative "../../../src/chapter_1/section_3/stack_exercises"
require_relative "../../test_helper"
require_relative "../../../src/utils/number_utils"

module Chapter1
  module Section3
    class StackExercises_test < TestHelper

      def initialize(args)
        super(args)
        @target = StackExercises.new
        @is_oper = /\W/
      end

      # Called after every test method runs. Can be used to tear
      # down fixture information.
      def teardown
        # Empty
      end

      # Write a stack method that receives a string
      # uses a stack to determine whether its parentheses
      # are properly.
      # For example, your program should return true for [()]{}{[()()]()}
      # and false for [(]).
      # This exercise is exercise 4 of: http://algs4.cs.princeton.edu/13stacks/
      def test_stack_checker_e134
        verify_method :stack_checker_e134,
                      :with =>
                          [
                              {param: "()", expect: true},
                              {param: "[]", expect: true},
                              {param: "{}", expect: true},
                              {param: "[()]", expect: true},
                              {param: "[", expect: false},
                              {param: "]", expect: false},
                              {param: "{", expect: false},
                              {param: "}", expect: false},
                              {param: "(", expect: false},
                              {param: ")", expect: false},
                              {param: "(]", expect: false},
                              {param: "{)", expect: false},
                              {param: "[(])", expect: false},
                              {param: "({)}", expect: false},
                              {param: "[()]{", expect: false},
                              {param: "[()]}", expect: false},
                              {param: "[()]]", expect: false},
                              {
                                  param: "[()]{}{[()()]()}",
                                  expect: true
                              }
                          ]
      end

      # Write a method postfix_evaluator_e1311 that takes a postfix expression
      # as a string parameter, evaluates it, and returns the value of the arithmetic operation.
      # Assume input is always in correct postfix format, you only need to
      # consider +, -, /, * operations.
      # Example:
      # input: 1 2 + output: 3
      # input: 1 2 3 + output: 6
      # input: 3 4 - 5 + output: 4
      # input: 3 4 - 5 * output: -5
      # input: 5 3 4 - * output: -5
      # input 3 4 5 - * output: -3
      # input: 3 4 + 5 6 * * 2 + output: 212
      def test_postfix_evaluator_e1311
        verify_method :postfix_evaluator_e1311,
                      :with =>
                          [
                              {param: '1 2 +', expect: 3},
                              {param: '1 2 3 +', expect: 6},
                              {param: '3 4 - 5 +', expect: 4},
                              {param: '3 4 - 5 *', expect: -5},
                              {param: '5 3 4 - *', expect: -5},
                              {param: '3 4 5 - *', expect: -3},
                              {param: '3 4 + 5 6 * * 2 +', expect: 212}
                          ]
      end

      # Depends on: postfix_evaluator_e1311
      # Write a method that converts an arithmetic expression from infix to postfix.
      # Using stacks to process the infix and postfix expressions
      # Assume input is always in correct infix format
      # Examples:
      #   input: '2+2' output:  '2 2 +'
      #   input: '2+2+2' output:  '2 2 2 +'
      #   input: '3-4+5' output:  '3 4 - 5 +'
      #   input: '(2+((3+4)*(5*6)))' output:  '3 4 + 5 6 * * 2 +'
      # Postfix documentation: http://en.wikipedia.org/wiki/Reverse_Polish_notation
      def test_infix_to_postfix_e1310
        verify_method :infix_to_postfix_e1310,
                      :with =>
                          [
                              {
                                  param: '1+2',
                                  predicate: Proc.new { |expr| check_expression_result(expr, 1+2) }
                              },
                              {
                                  param: '1+2+3',
                                  predicate: Proc.new { |expr| check_expression_result(expr, 1+2+3) }
                              },
                              {
                                  param: '1+2+3+4',
                                  predicate: Proc.new { |expr| check_expression_result(expr, 1+2+3+4) }
                              },
                              {
                                  param: '3-4+5',
                                  predicate: Proc.new { |expr| check_expression_result(expr, 3-4+5) }
                              },
                              {
                                  param: '(3-4)*5',
                                  predicate: Proc.new { |expr| check_expression_result(expr, (3 - 4)*5) }
                              },
                              {
                                  param: '(1+2)*3',
                                  predicate: Proc.new { |expr| check_expression_result(expr, (1+2)*3) }
                              },
                              {
                                  param: '(2+((3+4)*(5*6)))',
                                  predicate: Proc.new { |expr| check_expression_result(expr, (2+((3+4)*(5*6)))) }
                              }
                          ]
      end

      private

      # @param [String] expression
      # @param [Numeric] expected_result
      def check_expression_result(expression, expected_result)
        actual_result = evaluate_postfix_expression expression
        if actual_result != expected_result
          msg = "Expected: #{expected_result} but received: #{actual_result}, "
          msg += "with expression: #{expression}"

          puts msg
        end

        actual_result == expected_result
      end

      # Uses the postfix evaluator you wrote for exercise e1311 to
      # test your infix to postfix implementation.
      def evaluate_postfix_expression(postfix_input)
        unless @target.respond_to? :postfix_evaluator_e1311
          fail "You must solve test_postfix_evaluator_e1311 first"
        end

        begin
          return @target.postfix_evaluator_e1311(postfix_input)
        rescue Exception => error
          msg = "Bad postfix format: #{postfix_input}, #{error.message}"
          raise Test::Unit::AssertionFailedError.new(msg)
        end
      end

      def execute_operation(left_operand, right_operand, operator)
        oper_result = 0
        eval "oper_result = #{left_operand} #{operator} #{right_operand}"
        oper_result
      end

    end
  end
end