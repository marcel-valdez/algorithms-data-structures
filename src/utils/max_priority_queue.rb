# encoding: utf-8

require_relative 'number_utils'
require_relative 'base_priority_queue'

module Utils
  # The MaxPriorityQueue class represents a priority queue of generic keys.
  #
  # It supports the usual insert and delete-the-maximum operations, along
  # with methods for peeking at the maximum key, testing if the priority
  # queue is empty, and iterating through the keys.
  #
  # The insert and delete-the-maximum operations take logarithmic amortized
  # time. The max, size, and is-empty operations take constant time.
  # Construction takes time proportional to the specified capacity or the
  # number of items used to initialize the data structure.
  #
  # This implementation uses a binary heap.
  #
  # For additional documentation, see Section 2.4 of Algorithms, 4th Edition
  # by Robert Sedgewick and Kevin Wayne.
  class MaxPriorityQueue < BasePriorityQueue

    # MaxPriorityQueue()
    #   Create an empty priority queue.
    # MaxPriorityQueue() &block
    #   Create an empty priority queue using the given comparator.
    # MaxPriorityQueue(keys)
    #   Create a priority queue with the given items.
    def initialize(*args)
      super(*args)
    end

    #  Delete and return the largest key on the priority queue.
    # @return [Object] the largest key
    def delete_max
      raise 'Priority queue underflow' if is_empty?
      max_key = @keys[1]
      @keys.swap(1, @keys.length - 1)
      @keys.delete_at(@keys.length - 1)
      sink(1)
      max_key
    end

    # Return the largest key on the priority queue.
    # @return [Object] the largest key
    def max
      @keys[1]
    end

    # Return the number of items on the priority queue.
    # @return [Fixnum] the total number of items
    def size
      @keys.length - 1
    end

    protected

    def delete
      delete_max
    end

    def self_new
      MaxPriorityQueue.new { |*args| yield(*args) }
    end

    # sinks down the element at the given index from its current position
    # to the one it should be at, according to its key value (in heap-order)
    def sink(index)
      # << : fast multiplication with bit shifting
      until (index << 1) > size
        # iterate to parent of element
        iter = index << 1
        # if element is less than it's brother
        # iterate to it's brother
        iter+=1 if iter < size and less(iter, iter+1)
        # stop if the current element is greater than the one sinking
        break if greater(index, iter)
        # if its equal or greater, then swap it
        @keys.swap(index, iter)
        # set the index to the new position of the sinking element
        index = iter
      end
    end

    # brings up the element at the given index from its current position
    # to the one it should be at, according to it's key value (in heap-order)
    def swim(index)
      # >> : fast division with bit shifting
      while index > 1 and less(index/2, index)
        @keys.swap(index/2, index)
        index = index/2
      end
    end
  end
end