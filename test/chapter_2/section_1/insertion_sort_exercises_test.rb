require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_1/insertion_sort_exercises"
require_relative "../test_sort_helper"

module Chapter2
  module Section1
    class InsertionSortExercises_test < TestHelper

      include Chapter2::TestSortHelper

      def initialize(*args)
        super(*args)
        @target = InsertionSortExercises.new
      end

      # 2.1.25 Insertion sort without exchanges. Develop an implementation of insertion
      # sort that moves larger elements to the right one position with one array access per
      # entry, rather than exchanging.
      # Note: Your code must run faster than the implementation without this optimization.
      # 			and also provide a correct sort.
      def test_e2125_insertion_sort_no_swap
      	# puts "*** Executing insertion_sort_without_exchanges_e2125_test ***"
        check_sort_correctness :e2125_insertion_sort_no_swap

        hundred_elements = (0..100).to_a
        faster = Proc.new {
            @target.e2125_insertion_sort_no_swap(hundred_elements.shuffle)
        }

        slower = Proc.new {
          standard_insertion_sort(hundred_elements.shuffle)
        }

        assert_faster_proc faster, slower
      end

      def test_insertion_sort_helper
        # Arrange
        expected = (0..5).to_a
        values = expected.shuffle

        # Act
        actual = standard_insertion_sort(values)

        # Assert
        assert_equal(expected, actual)
      end

      def standard_insertion_sort(values)
        # while is used instead of .each to improve
        # efficiency (and make the exercise harder, lol)
        i = 0
        while i < values.length
          j = i
          while j > 0 and values[j] < values[j-1]
            swap(values, j, j-1)
            j-=1
          end

          i+=1
        end

        values
      end

      def swap(values, a, b)
        values[a], values[b] = values[b], values[a]
      end
    end
  end
end
