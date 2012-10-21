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

      # Write a filter that converts an arithmetic expression from infix to postfix.
      # Assume input is always in correct infix format
      # Examples:
      #   input: '2+2' output:  '2 2 +'
      #   input: '2+2+2' output:  '2 2 2 +'
      #   input: '3-4+5' output:  '3 4 - 5 +'
      #   input: '(2+((3+4)*(5*6)))' output:  '3 4 + 5 6 * * 2 +'
      # Postfix documentation: http://en.wikipedia.org/wiki/Reverse_Polish_notation
      def test_infix_to_postfix_e1310
        #verify_method :infix_to_postfix_e1310,
        #              :with =>
        #                  [
        #                      {
        #                          param: '1+2',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, 1+2) }
        #                      },
        #                      {
        #                          param: '1+2+3',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, 1+2+3) }
        #                      },
        #                      {
        #                          param: '1+2+3+4',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, 1+2+3+4) }
        #                      },
        #                      {
        #                          param: '3-4+5',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, 3-4+5) }
        #                      },
        #                      {
        #                          param: '(3-4)*5',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, (3 - 4)*5) }
        #                      },
        #                      {
        #                          param: '(1+2)*3',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, (1+2)*3) }
        #                      },
        #                      {
        #                          param: '(2+((3+4)*(5*6)))',
        #                          predicate: Proc.new { |expr| check_expression_result(expr, (2+((3+4)*(5*6)))) }
        #                      }
        #                  ]
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

      private

      # @param [String] expression
      # @param [Numeric] expected_result
      def check_expression_result(expression, expected_result)
        actual_result = evaluate_postfix_expression expression
        puts "Expected: #{expected_result} but received: #{actual_result}" if actual_result != expected_result
        actual_result == expected_result
      end

      def evaluate_postfix_expression(postfix_input)
        stack = Utils::Stack.new
        # Iterate every token
        begin
          tokens = postfix_input.split(' ')
          tokens.each_with_index { |token, index|
            # Encounter operator
            if token.match @is_oper
              begin
                # Set right operand
                right_operand = stack.pop
                # Set left operand
                left_operand = stack.pop
                # Append operation
                oper_result = execute_operation(left_operand, right_operand, token)
                stack.push oper_result
              end until stack.size < 2 || index < tokens.size - 1
            else
              stack.push token
            end
          }

        rescue Exception => error
          msg = "Bad postfix format: #{postfix_input}, #{error.message}"
          raise Test::Unit::AssertionFailedError.new(msg)
        end

        stack.pop
      end

      def execute_operation(left_operand, right_operand, operator)
        oper_result = 0
        eval "oper_result = #{left_operand} #{operator} #{right_operand}"
        oper_result
      end

    end
  end
end