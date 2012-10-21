# encoding: utf-8

require_relative "../../utils/point2d"
require_relative "../../utils/number_utils"
require_relative "../../utils/stack"

module Chapter1
  module Section3
    class StackExercises

      def initialize
        @is_oper = /\W/
        @is_paren = /\(\)/
      end

      # Write a stack method that receives a string
      # uses a stack to determine whether its parentheses
      # are properly.
      # For example, your program should print true for [()]{}{[()()]()}
      # and false for [(]).
      # This exercise is exercise 4 of: http://algs4.cs.princeton.edu/13stacks/
      def stack_checker_e134(input)
        # All left parens
        is_left = /[\(\{\[]/

        # Hash for right parens
        # Example: left_for[')'] == '('
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
            # if this is a right symbol, then the last pushed element must be its left complement
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
      def infix_to_postfix_e1310(infix)
        # TODO: Infix to Postfix
        tokens = infix.split('')
        # inner inner outer outer-outer
        # reduce 2 + 2 + 2 to 2 2
        result = ''
        temp_expr = ''
        # stack = Utils::Stack.new
        tokens.each { |token|
          # If its NOT a parenthesis
          if not token.eql? ')' and not token.eql? '('
            # puts "Number or Operand: #{token} found"
            # stack.push token
            temp_expr += " #{token}"
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
            temp_expr = ''
          end
        }

        result = extract_operation(infix) if result.empty?

        result
      end

      # Extracts an operations left operand, right operand and operator
      # NOTE: Currently I'm trying to make it
      # pass: 1+2, 1+2+3, 1+2+3+4
      # current: 3-4+5
      def extract_operation(infix_expr)
        operation = ""
        # recurse(left) recurse(right) operator ?
        #operation = "#{left_operand} #{right_operand} #{operator}"
        postfix_tokens = Utils::Stack.new
        #puts "operator regex: #{@is_oper}"
        infix_tokens = infix_expr.strip.split(' ')
        for i in 0...infix_tokens.length
          token = infix_tokens[i]
          # If the token is the operator
          if token.match @is_oper
            # puts "operator found: #{token}"
            partial = postfix_tokens.pop
            postfix_tokens.push "#{partial}"
          else
            # puts "number found: #{token}"
            postfix_tokens.push token
          end
        end

        last_oper = ""
        operation.rstrip!
        until postfix_tokens.is_empty?
          oper = postfix_tokens.pop
          puts "last_oper #{last_oper } and oper: #{oper}"
          operation += " #{oper}" unless last_oper == oper
          last_oper = oper
        end

        operation
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
      # Passes: All
      # Strategy: Build operands until an operator is found, then append the result, and repeat.
      def postfix_evaluator_e1311(postfix_input)
        #puts "Starting new postfix evaluation: #{postfix_input}"
        stack = Utils::Stack.new
        # Iterate every token
        tokens = postfix_input.split(' ')
        tokens.each_with_index { |token, index|
          # Encounter operator
          if token.match @is_oper
            begin
              #puts "    Items on stack: #{stack.size}"
              # Set right operand
              right_operand = stack.pop
              # Set left operand
              left_operand = stack.pop
              # Append operation
              oper_result = execute_operation(left_operand, right_operand, token)
              stack.push oper_result
              # loop until all operands are consumed or stop if this is not the last operator
            end until stack.size < 2 || index < tokens.size - 1
          else # If token is number
            stack.push token
          end
        }

        stack.pop
      end


      def execute_operation(left_operand, right_operand, operator)
        oper_result = 0
        #puts "\t executing: oper_result = #{left_operand} #{operator} #{right_operand}"
        eval "oper_result = #{left_operand} #{operator} #{right_operand}"
        oper_result
      end
    end
  end
end