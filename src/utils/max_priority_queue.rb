# encoding: utf-8
require_relative "number_utils"

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
    # MaxPriorityQueue(keys)
    #   Create a priority queue with the given items.
    def initialize(*args)
      if args.nil? or args.empty?
        @keys = [nil]
      elsif args[0].is_a? Array
        @keys = [nil].concat args[0]
      else
        raise "Invalid argument type #{args[0].class} received"
      end

      if block_given?
        @compare = lambda { |a, b| yield(a, b) }
      else
        @compare = lambda { |a, b| a <=> b }
      end
    end

    #  Delete and return the largest key on the priority queue.
    # @return [Object] the largest key
    def delete_max
      raise "Priority queue underflow" if is_empty?
      max_key = @keys[1]
      @keys.swap(1, @keys.length - 1)
      @keys.delete_at(@keys.length - 1)
      sink(1)
      max_key
    end

    # Add a new key to the priority queue.
    # @param [Object] key to insert
    def insert(key)
      @keys << key
      swim(@keys.length - 1)
    end

    # Is the priority queue empty?
    # @return [Boolean] true if empty, false otherwise
    def is_empty?
      size == 0
    end

    # Iterates over all of the keys on the priority queue in descending order.
    def each
      copy = MaxPriorityQueue.new { |a, b| compare(a, b) }
      @keys[1..size].each { |key| copy.insert key }

      yield copy.delete_max until copy.is_empty?
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

    private

    # sinks down the element at the given index from its current position
    # to the one it should be at, according to its key value (in heap-order)
    def sink(index)
      # << : fast multiplication with bit shifting
      # until we reach root
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

    # @param [Fixnum] i first index to swap with
    # @param [Fixnum] j second index to swap with
    def greater(i, j)
      compare(@keys[i], @keys[j]) > 0
    end

    # @param [Fixnum] i
    # @param [Fixnum] j
    def less(i, j)
      compare(@keys[i], @keys[j]) < 0
    end

    # @param [Object] a
    # @param [Object] b
    # @return [Fixnum] returns 1 if a > b, 0 if a == b and -1 if a < b
    def compare(a, b)
      @compare.call(a, b)
    end
  end
end