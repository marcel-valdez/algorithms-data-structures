class Point2D
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  # @param [Point2D] point at a distance
  # @return [Numeric] the distance to such a point
  def distance_to(point)
    Math.sqrt((@x - point.x)**2 + (@y - point.y)**2)
  end
end
