# encoding: utf-8
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
  class MaxPriorityQueue

    # MaxPriorityQueue()
    #   Create an empty priority queue.
    # MaxPriorityQueue() &block
    #   Create an empty priority queue using the given comparator.
    # MaxPriorityQueue(capacity)
    #   Create an empty priority queue with the given initial capacity.
    # MaxPriorityQueue(initCapacity) &block
    #   Create an empty priority queue with the given initial capacity, using
    #   the given comparator.
    # MaxPriorityQueue(keys)
    #   Create a priority queue with the given items.
    def initialize(*args)

    end

    #  Delete and return the largest key on the priority queue.
    # @return [Object] the largest key
    def delete_max
    end

    # Add a new key to the priority queue.
    # @param [Object] key to insert
    def insert(key)
    end

    # Is the priority queue empty?
    # @return [Boolean] true if empty, false otherwise
    def is_empty?
    end

    # Iterates over all of the keys on the priority queue in descending order.
    def each
    end

    # Return the largest key on the priority queue.
    # @return [Object] the largest key
    def max
    end

    # Return the number of items on the priority queue.
    # @return [Fixnum] the total number of items
    def size
    end
  end
end