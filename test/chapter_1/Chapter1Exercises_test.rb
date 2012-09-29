require "test/unit"
require_relative "../../src/chapter_1/Chapter1Exercises"
require_relative "../test_helper"

class Chapter1Exercises_test < TestHelper


  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @target = Chapter1Exercises.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end


  def test_exercise_113
    verify_method :exercise_1_1_3,
        :with => [{ param: "1 2 3", expected: false },
                  { param: "1 1 1", expected: true }]
  end


end