# encoding: utf-8

require_relative "../../utils/point2d"
require_relative "../../utils/number_utils"
require_relative "../../utils/stack"

module Chapter1
  module Section3
    class Exercises

      def initialize
        @is_oper = /\+\*\-\\/
        @is_paren = /\(\)/
      end

      # Write a stack method that receives a string
      # uses a stack to determine whether its parentheses
      # are properly.
      # For example, your program should print true for [()]{}{[()()]()}
      # and false for [(]).
      # This exercise is exercise 4 of: http://algs4.cs.princeton.edu/13stacks/
      def stack_checker_e134(input)
        is_left = /[\(\{\[]/
        left_for = {
            ')' => '(',
            '}' => '{',
            ']' => '['
        }

        stack = Utils::Stack.new
        input.split('').each { |symbol|
          if symbol.match is_left
            # puts "stack.push #{symbol}\n"
            stack.push symbol
            # Needs LIFO access, stack is LIFO?
          elsif left_for[symbol] != stack.pop
            # puts "left_for[#{symbol}]: #{left_for[symbol]}\n"
            return false
          end
        }

        # All elements in stack must be matched!
        stack.size == 0
      end


      # Write a filter that converts an arithmetic expression from infix to postfix.
      # Assume input is always in correct infix format
      # Examples:
      #   input: '2+2' output:  '2 2 +'
      #   input: '2+2+2' output:  '2 2 2 +'
      #   input: '3-4+5' output:  '3 4 - 5 +'
      #   input: '(2+((3+4)*(5*6)))' output:  '3 4 + 5 6 * * 2 +'
      def infix_to_postfix_e135(infix)
        # TODO: Infix to Postfix
        tokens = infix.split('')
        # inner inner outer outer-outer
        # reduce 2 + 2 + 2 to 2 2
        result = ''

        stack = Utils::Stack.new
        tokens.each { |token|
          # If its NOT a parenthesis
          unless token.eql? ')' or token.eql? '('
            # then push it on to the stack
            stack.push token
          end

          # If its the end of a operation
          if token.eql? ')'
            # Append the operation to the resulting postfix format:
            # We need to pull the operation
            # Problem: We cannot pull out just like tha
            # Idea: Stacks of Stacks
            result += extract_operation(token)
          end
        }

        result = extract_operation(tokens) if result.empty?

        result
      end

      # Extracts an operations left operand, right operand and operator
      # NOTE: Currently I'm trying to make it pass 1+2 and 1+2+3 input
      def extract_operation(tokens)
        operation = ""

        right_operand = tokens.pop
        operator = tokens.pop
        left_operand = tokens.pop

        operation = "#{left_operand} #{right_operand} #{operator}"
        last_oper = ""
        until tokens.size == 0 #or token.peek.match is_paren
          token = tokens.pop
          # If the token is the operator
          if token.match @is_oper
            operation += "#{token}" unless token.eql? last_oper
            last_oper = token
          else
            operation = "#{token} #{operation}"
          end
        end

        operation
      end
    end
  end
end