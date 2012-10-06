module Math
  def Math.min(a, b)
    a < b ? a : b
  end

  def Math.max(a, b)
    a > b ? a : b
  end
end

class Range
  # @param [Range] b
  # @return [boolean] true if it includes b, false otherwise
  def intersects? (b)
    cover?(b.first) or cover?(b.last) or b.cover?(self.last) or b.cover?(self.first)
  end

  # @param [Range] b
  # @return [boolean] true if it b is inside the range, false otherwise
  def contains? (b)
    cover? b.first and cover? b.last
  end

  # @param [Range] b
  # @return [boolean] true if b contains self, false otherwise
  def is_contained_by? (b)
    b.contains? self
  end
end