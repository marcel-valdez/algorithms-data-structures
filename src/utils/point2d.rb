class Point2D
  attr :x, :y

  # @param [Point2D] point at a distance
  # @return [Numeric] the distance to such a point
  def distance_to(point)
    Math.sqrt(Math.sqr(@x - point.x) + Math.sqr(@y - point.y))
  end
end
