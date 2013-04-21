# encoding: utf-8

module Utils
  class BasePriorityQueue
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


    # Return the number of items on the priority queue.
    # @return [Fixnum] the total number of items
    def size
      @keys.length - 1
    end

    # Iterates over all of the keys on the priority queue in descending order.
    def each
      copy = self_new { |a, b| compare(a, b) }
      @keys[1..size].each { |key| copy.insert key }

      yield copy.delete until copy.is_empty?
    end

    protected

    # Children of PriorityQueue must implement this method, and
    # return a new instance of themselves, this is used for the
    # each() iterator.
    def self_new
      raise "Not implemented."
    end

    # Children of PriorityQueue must implement this method
    def sink(index)
      raise "Not implemented."
    end

    # Children of PriorityQueue must implement this method
    def swim(index)
      raise "Not implemented."
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