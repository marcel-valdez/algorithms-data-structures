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
      # TODO: Add a Postfix Evaluator
      def test_infix_to_postfix_e1310
        #verify_method :infix_to_postfix_e1310,
        #              :with =>
        #                  [
        #                      {
        #                          param: '1+2',
        #                          expect: '1 2 +'
        #                      },
        #                      {
        #                          param: '1+2+3',
        #                          expect: '1 2 3 +'
        #                      },
        #                      {
        #                          param: '1+2+3+4',
        #                          expect: '1 2 3 4 +'
        #                      },
        #                      {
        #                          param: '3−4+5',
        #                          expect: '3 4 − 5 +'
        #                      },
        #                      {
        #                          param: '(3−4)*5',
        #                          expect: '3 4 - 5 *'
        #                      },
        #                      {
        #                          param: '(1+2)*3',
        #                          expect: '1 2 + 3 *'
        #                      },
        #                      {
        #                          param: '(2+((3+4)*(5*6)))',
        #                          expect: '3 4 + 5 6 * * 2 +'
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
                              {param: '5 3 4 - *', expect: -5},
                              {param: '3 4 5 - *', expect: -3},
                              {param: '3 4 + 5 6 * * 2 +', expect: 212}
                          ]
      end
    end
  end
end