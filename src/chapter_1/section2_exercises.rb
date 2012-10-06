require_relative "../utils/point2d"
require_relative "../utils/number_utils"

module Chapter1
  class Section2Exercises
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

    def include_intersect_e123 n, min, max
      # TODO: Implement this
    end

  end
end