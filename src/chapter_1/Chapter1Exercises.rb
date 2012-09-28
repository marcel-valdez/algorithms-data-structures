class Chapter1Exercises
  # To change this template use File | Settings | File Templates.
  def exercise_1_1_3 numbers
    integers = numbers.split(' ').each { |number| number.to_i}
    return integers.inject(integers[0]) do |value, integer|
      value == integer
    end
  end
end