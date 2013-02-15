# encoding: utf-8

require "test/unit"
require_relative "../../../src/chapter_1/section_2/exercises"
require_relative "../../test_helper"
require_relative "../../../src/utils/number_utils"

module Chapter1
  module Section2
    class Exercises_test < TestHelper

      def initialize(args)
        super(args)
        @target = Exercises.new
      end

      # 1.2.1 Write a Point2D method (src/utils/point2d.rb) that takes an integer value N as a parameter,
      # and generates random N points, computes the distance separating the closest pair of points, and
      # returns an array of points of Point2D with the generated points, and the distance between the
      # two closest points
      def test_e121_point_distance
        (1..30).each {#Idempotence verification
          verify_method :e121_point_distance,
                        :with => [{
                                      param: 2,
                                      predicate: Proc.new { |points_pairs, shortest|
                                        check_points(2, points_pairs, shortest)
                                      }},
                                  {
                                      param: 3,
                                      predicate: Proc.new { |points_pairs, shortest|
                                        check_points(3, points_pairs, shortest) }
                                  },
                                  {
                                      param: 5,
                                      predicate: Proc.new { |points_pairs, shortest|
                                        check_points(5, points_pairs, shortest) }
                                  },
                                  {
                                      param: 9,
                                      predicate: Proc.new { |points_pairs, shortest|
                                        check_points(9, points_pairs, shortest) }
                                  },
                                  {
                                      param: 30,
                                      predicate: Proc.new { |points_pairs, shortest|
                                        check_points(30, points_pairs, shortest) }
                                  }]
        }
      end

      # 1.e122_2.2 Write a method range_intersect that receives N Ranges (a..b), and returns all
      # pairs of ranges that intersect.
      # For example: 0..1, 1..2, 1..3 should return pairs: {0..1, 1..2}, {1..2, 1..3}, {0..1, 1..3}
      def test_e122_range_intersect
        verify_method :e122_range_intersect,
                      :with =>
                          [
                              {param: [0..1, 0..1], expect: [[0..1, 0..1]]},
                              {param: [0..1, 2..3], expect: []},
                              {param: [0..3, 1..2], expect: [[0..3, 1..2]]},
                              {param: [1..2, 0..3], expect: [[1..2, 0..3]]},
                              {param: [0..1, 1..2], expect: [[0..1, 1..2]]},
                              {param: [0..1, 0..1, 0..1], expect: [[0..1, 0..1], [0..1, 0..1], [0..1, 0..1]]},
                              {
                                  param: [0..1, 1..2, 2..3],
                                  predicate: Proc.new { |result|
                                    result.include? [0..1, 1..2] and result.include? [1..2, 2..3]
                                  }
                              },
                              {
                                  param: [0..1, 1..2, 1..3],
                                  predicate: Proc.new { |result|
                                    result.include? [0..1, 1..2] and result.include? [1..2, 1..3] and result.include? [0..1, 1..3]
                                  }
                              },
                          ]
      end

      # 1.2.3 Write a program that receives N, min, and max, and generates N ranges with a
      # start between min..max and end between min..max, then calculates all pairs of ranges
      # that intersect and all pairs of ranges contained one inside the other. The method
      # should return all generated ranges, intersecting ranges and ranges contained.
      # For example: 3, 1, 4 *could* return [ [1..2, 1..3, 3..4], [[1..2, 1..3],[1..3, 3..4]], [[1..2, 1..3]]]
      # Assume N > 1 and min < max and min >= 0
      def test_e123_include_intersect
        verify_method :e123_include_intersect,
                      :with =>
                          [
                              {
                                  params: [2, 1, 2],
                                  predicate: Proc.new { |all, intersect, include| check_included_intersected(2, 1, 2, all, intersect, include) }
                              },
                              {
                                  params: [5, 1, 10],
                                  predicate: Proc.new { |all, intersect, include| check_included_intersected(5, 1, 10, all, intersect, include) }
                              }
                          ]

      end

      # TODO: Add the rest of exercises for Chapter 1 Section 2

      private

      def check_included_intersected (n, min, max, all_ranges, intersected_pairs, included_pairs)
        if n != all_ranges.length
          puts "Expected #{n} ranges, but received #{all_ranges.length} ranges: #{all_ranges.inspect}"
          return false
        end

        invalid = all_ranges.select { |range| range.first > range.last or range.first < min or range.last > max }
        if invalid.length != 0
          invalid.each { |invalid_range| puts "Range: #{invalid_range.inspect} is outside of min:#{min} max:#{max} limits." }
          return false
        end

        intersected_pairs.each_with_index { |pair, index|
          unless pair[0].intersects? pair[1]
            puts "pair #{pair.inspect} at index: #{index}, does not intersect."
            return false
          end
        }

        included_pairs.each_with_index { |pair, index|
          unless pair[0].contains? pair[1] or pair[0].is_contained_by? pair[1]
            puts "pair #{pair.inspect} at index #{index}, are not inclusive."
            return false
          end
        }

        true
      end

      def check_points(n = 0, generated_points = [], actual_shortest = 0)
        shortest = nil
        generated_points.each_with_index { |point, index|
          generated_points.each { |other_point|
            unless other_point.eql? point
              distance = point.distance_to other_point
              shortest = distance if shortest.nil? or shortest > distance
              break if shortest.eql? 0
            end
          }
        }

        if n != generated_points.length
          puts "Expected #{n} pairs but found #{generated_points.length}: #{generated_points.inspect}"
        end

        if actual_shortest != shortest
          puts "Expected shortest #{shortest}but found #{actual_shortest}. Points:#{generated_points.inspect}"
        end

        n == generated_points.length and actual_shortest == shortest
      end
    end
  end
end