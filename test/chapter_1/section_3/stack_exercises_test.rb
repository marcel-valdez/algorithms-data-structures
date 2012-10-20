# encoding: utf-8

require "test/unit"
require_relative "../../../src/chapter_1/section_3/stack_exercises"
require_relative "../../test_helper"
require_relative "../../../src/utils/number_utils"

module Chapter1
  module Section3
    class Exercises_test < TestHelper

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
      def test_infix_to_postfix_e135
        verify_method :infix_to_postfix_e135,
                      :with =>
                          [
                              {
                                  param: '1+2',
                                  expect: '1 2 +'
                              },
                              {
                                  param: '1+2+3',
                                  expect: '1 2 3 +'
                              },
                              {
                                  param: '1+2+3+4',
                                  expect: '1 2 3 4+'
                              },
                              {
                                  param: '3−4+5',
                                  expect: '3 4 − 5 +'
                              },
                              {
                                  param: '(3−4)*5',
                                  expect: '3 4 - 5 *'
                              },
                              {
                                  param: '(1+2)*3',
                                  expect: '1 2 + 3 *'
                              },
                              {
                                  param: '(2+((3+4)*(5*6)))',
                                  expect: '3 4 + 5 6 * * 2 +'
                              }
                          ]
      end
    end
  end
end