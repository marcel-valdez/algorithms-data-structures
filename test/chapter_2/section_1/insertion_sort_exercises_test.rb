require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_1/insertion_sort_exercises"

module Chapter2
  module Section1
    class InsertionSortExercises_test < TestHelper

      def initialize(*args)
        super(*args)
        @target = InsertionSortExercises.new
      end

      # 2.1.25 Insertion sort without exchanges. Develop an implementation of insertion
      # sort that moves larger elements to the right one position with one array access per
      # entry, rather than exchanging.
      # Note: Your code must run faster than the implementation without this optimization.
      # 			and also provde a correct sort.
      def test_insertion_sort_without_exchanges_e2125
      	# puts "*** Executing insertion_sort_without_exchanges_e2125_test ***"
        # Arrange
        expected = (0..4).to_a
        values = (0..4).to_a.shuffle

        # Act
        verify_method :insertion_sort_without_exchanges_e2125,
        :with => [
          {
            param: values,
            # Assert
            expect: expected
          }
        ]

        parameter = (0..100).to_a.shuffle
        optimized_time = time_block {
          @target.insertion_sort_without_exchanges_e2125(parameter)
        }

        parameter = (0..100).to_a.shuffle
        suboptimal_time = time_block {
          insertion_sort(parameter)
        }

        # Compare to suboptimal implementation
        assert_operator optimized_time, :<, suboptimal_time

      end

      def test_insertion_sort_helper
      	# puts "Executing insertion_sort_helper_test"
        # Arrange
        values = (0..5).to_a.shuffle
        expected = (0..5).to_a

        # Act
        actual = insertion_sort(values)

        # Assert
        assert_equal(expected, actual)
      end

      def insertion_sort(values)
        for i in 0...values.length
          j = i
          while j > 0 and values[j] < values[j-1]
            exchange(values, j, j-1)
            j-=1
          end
        end

        values
      end

      def exchange(values, a, b)
        temp = values[a]
        values[a] = values[b]
        values[b] = temp
      end
    end
  end
end
