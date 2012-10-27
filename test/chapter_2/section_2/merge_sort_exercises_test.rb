#encoding: utf-8

require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_2/merge_sort_exercises"

module Chapter2
  module Section2
    class MergeSortExercises_test < TestHelper

      def initialize(*args)
        super(*args)
        @target = MergeSortExercises.new
      end
    end
  end
end
