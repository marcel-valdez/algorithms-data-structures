# encoding: utf-8

require_relative "../../test_helper"
require_relative "../../../src/chapter_2/section_4/priority_queue_exercises"
require_relative "../test_sort_helper"
require_relative "../../utils/memory_analyzer"

module Chapter2
  module Section3
    # This class contains the tests for exercises pertaining the
    # PriorityQueue data structure. If the student wishes to truly
    # understand the PriorityQueue, it is recommended that he/she also
    # implements the min_priority_queue and base_priority_queue from scratch,
    # using the utils/min_priority_queue_test and utils/max_priority_queue_test
    # tests for guiding his/her TDD coding of their implementation.
    class PriorityQueueExercises_test < TestHelper

      # @param [Object] args
      def initialize(*args)
        super(*args)
        @target = nil
      end

      # Exercise 2.4.25 Part A
      # Computational number theory. Write a program that prints out all
      # integers of the form a³ + b³ where a and b are integers between 0 and N
      # in sorted order, without using excessive memory space.
      # That is, instead of computing an array of the N² sums and sorting them,
      # build a minimum-oriented priority queue, initially containing:
      # (0³, 0, 0), (1³, 1, 0), (2³, 2, 0), . . ., (N³, N, 0).
      # Then, while the priority queue is nonempty,
      # remove the smallest item (i³ + j³, i, j), print it, and then,
      # if j < N, insert the item (i³ + (j+1)³, i, j+1)
      # Your function must return an object that implements the Enumerable
      # each method, that returns the arrays, such as:
      # For N = 2
      # Valid array order: [0,0,0], [1,0,1], [1,1,0],
      #                    [2,1,1], [8,0,2], [8,2,0],
      #                    [9,1,2], [9,2,1], [16, 2, 2]
      #
      # Valid array size: 9 (N+1)²
      # This test will check that the object returned by
      # PriorityQueueExercises.number_theory_e2425 is smaller memory-wise than
      # an array with the results for N=10.
      def test_number_theory_e2425
        # Arrange
        @target = PriorityQueueExercises.new

        # Act/Assert
        verify_method :number_theory_e2425,
                      with: [
                              {
                                param:     1,
                                predicate: lambda { |res|
                                  check_number_theory_e2425(1, res)
                                }
                              },
                              {
                                param:     2,
                                predicate: lambda { |res|
                                  check_number_theory_e2425(2, res)
                                }
                              },
                              {
                                param:     10,
                                predicate: lambda { |res|
                                  check_number_theory_e2425(10, res)
                                }
                              }
                            ]

        # Clean
        @target = nil
      end

      # Exercise 2.5.25 Part B
      # Using the Enumerable object from exercise e2425, find all the distinct
      # integers a, b, c, d between 0 and 10⁶ such that:
      # a³ + b³ = c³ + d³


      private

      # Checks the result of exercise e2425
      # @param [Enumerable] result
      # @return [boolean] true if valid, false otherwise.
      def check_number_theory_e2425(param, result)
        assert_not_nil result, "Result should not be null"

        expected_size   = (param+1)**2
        previous        = 0
        resulting_array = []
        result.each { |tuple|
          sum = tuple[0]
          i   = tuple[1]
          j   = tuple[2]

          assert_equal sum, i**3 + j**3
          assert_operator sum, :>=, previous,
                          "Result should be given in ascending order."
          resulting_array << tuple
        }

        assert_equal expected_size, resulting_array.size,
                     "Result should be of size #{expected_size}"

        result_mem     = Memory.analyze result
        result_arr_mem = Memory.analyze resulting_array

        if param >= 10
          assert_operator result_mem[:bytes], :<, result_arr_mem[:bytes],
                          "The Enumerable object should use less memory than " +
                            "the actual results array."
        end

        true
      end
    end
  end
end
