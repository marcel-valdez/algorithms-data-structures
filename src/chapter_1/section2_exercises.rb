# encoding: utf-8

require_relative "../utils/point2d"
require_relative "../utils/number_utils"
require_relative "../utils/stack"

module Chapter1
  class Section2Exercises

    def initialize
      @is_oper = /\+\*\-\\/
      @is_paren = /\(\)/
    end

    #def is_oper
    #  /\+\*\-\\/
    #end
    #
    #def is_paren
    #  /\(\)/
    #end


    def point_distance_e121 n
      # All numbers will be within a range 0,0 to n.n
      # PointMap[x][y]: I know that the real Point2D(x,y) is going to be x/n, y/n) where x=[0,n] and y=[0,n]
      points = Array.new(n) { Array.new(n) }
      all_points = []
      shortest = 2*n
      # Loop 1 to N
      (1..n).each {
        # Create a point with random X and Y
        x = rand 0..(n-1)
        y = rand 0..(n-1)
        point = Point2D.new(Float(x)/n, Float(y)/n)
        all_points.push(point)

        if points[x][y].nil?
          points[x][y] = point # Should I calculate until the end or while generating? Until the end
        else
          shortest = 0
        end
        # Compare it to all other points? <-- Inefficient:
        #                                   Q: Can it be done more efficiently?
        #                                   A: Yes, if points are ordered by X and Y, then it is only a matter of
        #                                      comparing the closest points.
        # If the calculated value is less than the stores lowest, set new length
      }

      if shortest != 0
        # Calculate distance to all points
        # loop all points
        points.each_with_index { |row, y|
          row.each_with_index { |current_point, x|
            unless current_point.nil?
              # only look for points that can be near enough to current point
              y_range = (y+1)..Math.min(n-1, y + shortest)
              x_range = (x+1)..Math.min(n-1, x + shortest)
              # loop all points that can be shorter, except current
              y_range.each { |other_y|
                x_range.each { |other_x|
                  other_point = points[other_x][other_y]
                  unless (x == other_x and y == other_y) or other_point.nil?
                    distance = current_point.distance_to other_point
                    shortest = distance if shortest > distance
                    # (don't calculate points that are too far)
                  end
                }
              }

            end
          }
        }
      end
      # return points and shortest length

      return all_points, shortest
    end

    def range_intersect_e122 ranges = []
      # It is similar to the points intersection, but for ranges.
      intersected_pairs = []
      # loop ranges from 0 to n-1
      ranges.each_with_index { |range_i, i| # get range Ri
                                            #   loop ranges from i+1 to n-1 -> So we don't compare to Ro..Ri-1 that already compared themselves to Ri
        ranges.drop(i+1).each { |range_j| # get range Rj
                                          #     determine if Ri intersects Rj
                                          #       if so add Ri,Rj to results
          intersected_pairs.push([range_i, range_j]) if range_i.intersects? range_j
        }
      }

      intersected_pairs
    end

    # Write a program that receives N, min, and max, and generates N ranges with a start between min..max and
    # end between min..max, then calculates all pairs of ranges that intersect and all pairs of ranges contained
    # one inside the other. The method should return all generated ranges, intersecting ranges and ranges contained
    # For example: 3, 1, 4 *could* return [ [1..2, 1..3, 3..4], [[1..2, 1..3],[1..3, 3..4]], [[1..2, 1..3]]]
    # Assume N > 1 and min < max and min >= 0
    def include_intersect_e123 (n, min, max)
      min_max = min..max
      ranges = []
      # loop i=1 a N
      (1..n).each { |i|
        # generate Ri with start = rand(min, max), end = (start, max) -> Note if start == max, then Range.length = 1
        start = rand(min_max)
        min_max_i = start..max
        finish = rand(min_max_i)
        range = start..finish
        ranges.push(range)
      }

      intersected = []
      contained = []
      # loop Ri to Rn, i=1 to N
      ranges.each_with_index { |range_i, i|
        # loop Rj to Rn, j=i+1 to N
        ranges.drop(i+1).each { |range_j|
          # Ri intersects Rj?
          if range_i.intersects? range_j
            # push [Ri,Rj] to I
            intersected.push([range_i, range_j])
            # Ri contains? Rj or Rj contains? Ri
            if range_i.contains? range_j or range_i.is_contained_by? range_j
              # push [Ri, Rj] to C
              contained.push([range_i, range_j])
            end
          end
        }
      }

      return ranges, intersected, contained
    end

    # Write a stack method that receives a string
    # uses a stack to determine whether its parentheses
    # are properly.
    # For example, your program should print true for [()]{}{[()()]()}
    # and false for [(]).
    # This exercise is exercise 4 of: http://algs4.cs.princeton.edu/13stacks/
    def stack_checker_e124(input)
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
    def infix_to_postfix_e125(infix)
      # TODO: Infix to Postfix
    tokens = infix.split('')
      # inner inner outer outer-outer
      # reduce 2 + 2 + 2 to 2 2 +
      result = ''

      stack = Utils::Stack.new
      tokens.each { |token|
        unless token.eql? ')' or token.eql? '('

          stack.push token
        end

        if token.eql? ')'
          # We need to pull the operation
          # Problem: We cannot pull out just like tha
          # Idea: Stacks of Stacks
          result += extract_operation(token)
        end
      }

      result = extract_operation(tokens) if result.empty?

      result
    end

    def extract_operation(tokens)
      operation = ""
      last_oper = ''
      until tokens.size == 0 #or token.peek.match is_paren
        token = tokens.pop
        # NOTE: I'm trying to make it pass 2+2 and 2+2+2
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