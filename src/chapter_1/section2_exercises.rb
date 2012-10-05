require_relative "../utils/point2d"
class Section2Exercises
  def point_distance_e121 n
    # All numbers will be within a range 0,0 to n.n
    max_x = n
    max_y = n
    points = Array.new(n)
    shortest = nil
    # Loop 1 to N
    (1..n).each { |number|
      # Create a point with random X and Y
      x = rand n
      y = rand n
      point = Point2D.new(x, y)
      points.push(points)
      # Compare it to all other points? <-- Inefficient: Q: Can it be done more efficiently?
      # If the calculated value is less than the stores lowest, set new length
    }
    # return points and shortest length

    return points, shortest
  end
end