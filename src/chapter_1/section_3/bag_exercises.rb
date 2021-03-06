# encoding: utf-8

require_relative '../../utils/bag'

module Chapter1
  module Section3
    class BagExercises
      def initialize
        @bag = Utils::Bag.new
      end

      # Exercise 1.3.34
      # Write a method that returns the items of a bag in a random order
      def e1334_random_bag (values)
        length = values.length

        (0...length).each { |i|
          random_index = Random.rand(length)
          value_at_random_index = values[random_index]
          values[random_index] = values[i]
          values[i] = value_at_random_index
        }

        values
      end
    end
  end
end
