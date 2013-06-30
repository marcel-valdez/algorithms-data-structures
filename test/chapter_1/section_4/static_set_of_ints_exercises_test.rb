# encoding: utf-8

require_relative '../../test_helper'
require_relative '../../../src/chapter_1/section_4/static_set_of_ints_exercises'

module Chapter1
  module Section4
  # This class contains the tests for the StaticSetOfIntsExercises class.
  # The static set of ints is a simple data structure that does not ensure
  # ordering of a set of elements.
    class StaticSetOfIntsExercisesTest < TestHelper
      # Called before every test method runs. Can be used
      # to set up fixture information.
      def initialize(*args)
        super(*args)
        @target = StaticSetOfIntsExercises.new [3, 4, 5, 6, 0, 0, 0, 6, 6, 7, 7, 7, 2, 2, 2, 2, 2, 0, 3, 4, 3, 7]
      end

      # 1.4.11 Add an instance method howMany() to StaticSETofInts (page 99)
      # that finds the number of occurrences of a given key
      # in time proportional to log N in the worst case.
      def test_e1411_how_many
        verify_method :e1411_how_many,
                      :with => [{param: 3, expect: 3},
                                {param: 5, expect: 1},
                                {param: 4, expect: 2},
                                {param: 6, expect: 3},
                                {param: 2, expect: 5},
                                {param: 1, expect: 0},
                                {param: 8, expect: 0}]
      end
    end
  end
end