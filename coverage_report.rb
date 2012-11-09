require 'simplecov'

SimpleCov.start do
  add_filter('/test/')

  add_group('interview exercises', 'src/interview_exercises.rb')
  add_group('utilities', 'src/utils')
  add_group('chapter 1', 'src/chapter_1')
  add_group('chapter 2', 'src/chapter_2')
  add_group('chapter 3', 'src/chapter_3')
  add_group('chapter 4', 'src/chapter_4')
  add_group('chapter 5', 'src/chapter_5')
  add_group('chapter 6', 'src/chapter_6')
end

require_relative "run_test"