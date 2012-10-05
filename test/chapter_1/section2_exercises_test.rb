require "test/unit"
require_relative "../../src/chapter_1/section2_exercises"
require_relative "../test_helper"

class Section1Exercises_test < TestHelper
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @target = Section2Exercises.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  def check_points(n, points_pairs, shortest)
    current_shortest = nil

    points_pairs.each { |pair|
      distance = (pair[0]).distance_to pair[1]
      current_shortest = distance if current_shortest.nil? or current_shortest > distance
    }

    puts "Expected #{n} pairs but found #{points_pairs.length}" unless n == points_pairs.length
    puts "Expected shortest #{current_shortest} but found #{shortest}" unless current_shortest == shortest
    n == points_pairs.length and current_shortest == shortest
  end

  # Write a Point2D method (src/utils/point2d.rb) that takes an integer value N as a parameter, and generates
  # random N points, computes the distance separating the closest pair of points, and returns an array of pairs of Point2D
  # with the generated points, and the distance between the two closest points
  def test_point_distance_e121
    verify_method :point_distance_e121,
                  :with => [{param: 2, predicate: Proc.new { |points_pairs, shortest| check_points(2, points_pairs, shortest)}},
                            {param: 3, expected: Proc.new { |points_pairs, shortest| check_points(3, points_pairs, shortest)}}]
  end

end
