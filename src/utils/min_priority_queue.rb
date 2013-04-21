# encoding: utf-8

require_relative 'number_utils'
require_relative 'base_priority_queue'

module Utils
  # The MinPQ class represents a priority queue of generic keys. It supports
  # the usual insert and delete-the-minimum operations, along with methods for
  # peeking at the minimum key, testing if the priority queue is empty, and
  # iterating through the keys.
  #
  # The insert and delete-the-minimum operations take logarithmic amortized
  # time. The min, size, and is-empty operations take constant time.
  # Construction takes time proportional to the specified capacity or the
  # number of items used to initialize the data structure.
  #
  # This implementation uses a binary heap.
  #
  # For additional documentation, see Section 2.4 of Algorithms, 4th Edition
  # by Robert Sedgewick and Kevin Wayne.
  class MinPriorityQueue < BasePriorityQueue

    # MinPriorityQueue()
    #   Create an empty priority queue.
    # MinPriorityQueue() &block
    #   Create an empty priority queue using the given comparator.
    # MinPriorityQueue(keys)
    #   Create a priority queue with the given items.
    def initialize(*args)
      super(*args)
    end

    # Delete and return the smallest key on the priority queue.
    def delete_min
      raise 'Priority queue underflow' if is_empty?
      min_key = @keys[1]
      @keys.swap(1, @keys.length - 1)
      @keys.delete_at(@keys.length - 1)
      sink(1)
      min_key
    end

    # Return the largest key on the priority queue.
    # @return [Object] the largest key
    def min
      @keys[1]
    end

    protected

    def delete
      delete_min
    end

    def self_new
      MinPriorityQueue.new { |*args| yield(*args) }
    end

    # sinks down the element at the given index from its current position
    # to the one it should be at, according to its key value (in heap-order)
    def sink(index)
      # << : fast multiplication with bit shifting
      # until we reach root
      until (index << 1) > size
        # iterate to parent of element
        iter = index << 1
        # if element is greater than it's brother
        # iterate to it's brother
        iter+=1 if iter < size and greater(iter, iter+1)
        # stop if the current element is less than the one sinking
        break unless greater(index, iter)
        # if its equal or greater, then swap it
        @keys.swap(index, iter)
        # set the index to the new position of the sinking element
        index = iter
      end
    end

    # brings up the element at the given index from its current position
    # to the one it should be at, according to it's key value (in heap-order)
    def swim(index)
      while index > 1 and greater(index/2, index)
        @keys.swap(index/2, index)
        index = index/2
      end
    end
  end
end