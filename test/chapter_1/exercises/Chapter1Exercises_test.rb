require "test/unit"
require_relative "../../../src/chapter_1/Chapter1Exercises"

class Chapter1Exercises_test < Test::Unit::TestCase
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_exercise_113
    # Arrange
    test_cases = [{ numbers: "1 2 3", expected: false }, { numbers: "1 1 1", expected: false }]
    test_cases.each do |test_case|
        x = Chapter1Exercises.new

        # Act
        actual = x.exercise_1_1_3(test_case[:numbers])

        # Assert
        assert_equal(test_case[:expected], actual)
    end
  end
end