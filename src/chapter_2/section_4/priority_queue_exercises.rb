# encoding: utf-8
require_relative "../../utils/min_priority_queue"

module Chapter2
  module Section3
    # This class contains the solved exercises pertaining the PriorityQueue
    # data structure.
    class PriorityQueueExercises

      # 2.4.25 Computational number theory. Write a program that prints out all
      # integers of the form a³ + b³ where a and b are integers between 0 and N
      # in sorted order, without using excessive memory space.
      # That is, instead of computing an array of the N² sums and sorting them,
      # build a minimum-oriented priority queue, initially containing:
      # (0³, 0, 0), (1³, 1, 0), (2³, 2, 0), . . ., (N³, N, 0).
      # Then, while the priority queue is nonempty,
      # remove the smallest item (i³ + j³, i, j), print it, and then,
      # if j < N, insert the item (i³ + (j+1)³, i, j+1)
      # @param [Fixnum] size
      # @return [Enumerable]
      def number_theory_e2425(size)
        NumberHolder.new size
      end

      private
      class NumberHolder
        def initialize(size)
          @size = size
          @minpq = ::Utils::MinPriorityQueue.new { |a, b| compare_tuple(a, b) }
          (0..size).to_a.each { |num|
            @minpq.insert([num**3, num, 0])
          }
        end

        # @param [Array] a
        # @param [Array] b
        def compare_tuple(a, b)
          a[0] <=> b[0]
        end

        def each
          until @minpq.is_empty?
            min = @minpq.delete_min
            i = min[1]
            j = min[2]
            yield min
            if j < @size
              @minpq.insert [i**3 + (j+1)**3, i, j+1]
            end
          end
        end
      end
    end
  end
end