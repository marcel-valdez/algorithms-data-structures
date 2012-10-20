# encoding: utf-8

require_relative "../../utils/point2d"
require_relative "../../utils/number_utils"
require_relative "../../utils/stack"

module Chapter1
  module Section3
    class StackExercises

      def initialize
        @is_oper = /(\+|\*|-|\\)/
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
            # ) implies that I have to extract an operation until the
            # last )
            result += extract_operation(token)
          end
        }

        result = extract_operation(tokens) if result.empty?

        result
      end

      # Extracts an operations left operand, right operand and operator
      # NOTE: Currently I'm trying to make it
      # pass: 1+2, 1+2+3, 1+2+3+4
      # current: 3-4+5
      def extract_operation(tokens)
        operation = ""
        # recurse(left) recurse(right) operator ?
        #operation = "#{left_operand} #{right_operand} #{operator}"
        operator_stack = Utils::Stack.new
        #puts "operator regex: #{@is_oper}"
        until tokens.size == 0#or token.peek.match is_paren
          token = tokens.pop
          # If the token is the operator
          if token.match @is_oper
            puts "operator found: #{token}"
            operator_stack.push token
          else
            puts "number found: #{token}"
            operation = "#{token} #{operation}"
          end
        end

        last_oper = ""
        until operator_stack.is_empty?
          oper = operator_stack.pop
          puts "last_oper #{last_oper } and oper: #{oper}"
          operation += "#{oper}" unless last_oper == oper
          last_oper = oper
        end

        operation
      end
    end
  end
end