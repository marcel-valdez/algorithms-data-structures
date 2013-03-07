# encoding: utf-8

require_relative "../../utils/point2d"
require_relative "../../utils/number_utils"
require_relative "../../utils/stack"

module Chapter1
  module Section2
    class Exercises

      def initialize
      end

      def e121_point_distance(n)
        # All numbers will be within a range 0,0 to n.n
        # PointMap[x][y]: I know that the real Point2D(x,y) is going to be x/n, y/n) where x=[0,n] and y=[0,n]
        points = Array.new(n) { Array.new(n) }
        all_points = []
        shortest = 2*n
        # Loop 1 to N
        (1..n).each {
          # Create a point with random X and Y
          x = rand(n-1)
          y = rand(n-1)
          point = Point2D.new(Float(x)/n, Float(y)/n)
          all_points << point

          if points[x][y].nil?
            points[x][y] = point # Should I calculate until the end or while generating? Until the end
          else
            shortest = 0
          end
          # Compare it to all other points? <-- Inefficient:
          #                                   Q: Can it be done more efficiently?
          #                                   A: Yes, if points are ordered by X and Y, then it is only a matter of
          #                                      comparing the closest points.
          # If the calculated value is less than the stored lowest, set new length
        }

        if shortest != 0
          # Calculate distance to all points
          # loop all points
          points.each_with_index { |row, y|
            row.each_with_index { |current, x|
              unless current.nil?
                # only look for points that can be near enough to current point
                max_y = n-1#Math.min(n-1, (y + shortest).ceil)
                y_range = y..max_y
                min_x = Math.max(0, Integer(x-shortest))
                max_x = n-1#Math.min(n-1, (x + shortest).ceil)
                x_range = min_x..max_x
                # loop all points that can be shorter, except current
                y_range.each { |other_y|
                  x_range.each { |other_x|
                    if other_y != y or other_x != x
                      other = points[other_y][other_x]
                      if !other.nil? and current != other
                        distance = current.distance_to other
                        shortest = distance if shortest > distance
                        # (don't calculate points that are too far)
                      end
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

      def e122_range_intersect(ranges)
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
      def e123_include_intersect (n, min, max)
        ranges = []
        # loop i=1 a N
        (1..n).each {
          # generate Ri with start = rand(min, max), end = (start, max) -> Note if start == max, then Range.length = 1
          start = rand(max - min) + min
          finish = rand(max - start) + start
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

    end
  end
end