require_relative "../../test_helper"
require_relative "../../../src/chapter_1/section_4/static_set_of_ints_exercises"

module Chapter1
	module Section4
		class StaticSetOfIntsExercisesTest < TestHelper
			# Called before every test method runs. Can be used
			# to set up fixture information.
			def initialize(*args)
				super(*args)
				@target = StaticSetOfIntsExercises.new [3,4,5,6,2,3,4,3]
			end

			# 1.4.11 Add an instance method howMany() to StaticSETofInts (page 99) 
			# that finds the number of occurrences of a given key 
			# in time proportional to log N in the worst case.
			def test_how_many_e1411
				verify_method :how_many_e1411,
                      :with =>[{param: 3, expect: 3},
                      	 {param: 1, expect: 0},
                      	 {param: 5, expect: 1},
                      	 {param: 4, expect: 2}]
			end

		end
	end
end