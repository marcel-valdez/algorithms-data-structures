# encoding: utf-8

require_relative 'queue'

module Utils
  class SymbolTable
    include Enumerable

    def initialize
      @first = nil
      @max_key = nil
      @size = 0
    end

    def min
      @first.nil? ? nil : @first.key
    end

    def max
      @max_key
    end

    def put (key, value)
      orig_node = get_node(@first, key)
      if orig_node.nil? # if its a new value
        new_node = KeyValuePair.new(key, value)
        @first = put_sorted(@first, new_node) # put the new node in order
        @size += 1 # increase the size

        if @max_key.nil? or new_node.key > @max_key # if a new max is found
          @max_key = new_node.key # update the max
        end
      else
        if value.nil? # if the value is nil
          delete(key) # it is a deletion
        else # otherwise
          orig_node.value = value # overwrite the previous value
        end
      end
    end

    def each
      current = @first
      until current.nil?
        yield current.key, current.value
        current = current.next
      end
    end

    def get (key)
      node = get_node(@first, key)
      (not node.nil?) ? node.value : nil
    end

    def contains? (key)
      current = @first
      # advance the node until we reach the end or find a node key >= criteria
      current = current.next until current.nil? or current.key >= key
      # return true if we found the node
      !current.nil? and current.key == key
    end

    def floor (key)
      iterator = @first
      floor_key = nil
      # until we reach the end or find a node key >= criteria
      until iterator.nil? or iterator.key > key
        floor_key = iterator.key # update the floor key
        iterator = iterator.next # iterate
      end

      floor_key
    end

    def ceiling (key)
      iterator = @first
      # advance a node until we reach the end or find a key >= criteria
      iterator = iterator.next until iterator.nil? or iterator.key >= key
      # if the ceiling was found, return the key otherwise return nil
      iterator.key >= key ? iterator.key : nil
    end

    def rank (key)
      count = 0
      current = @first
      until current.nil? or current.key >= key
        count += 1
        current = current.next
      end

      count
    end

    def select (num_rank)
      iterator = @first
      count = 0
      # loop until we reach the end or reach the rank count
      until iterator.nil? or count == num_rank
        count += 1 # increment the rank count
        iterator = iterator.next # iterate
      end
      # if the rank was reached return the key, otherwise return nil
      count == num_rank ? iterator.key : nil
    end

    def keys(*args)
      if args.size > 0 and not args.nil?
        lo, hi = *args
      else
        lo, hi = min, max
      end

      keys_in(lo, hi)
    end

    def is_empty?
      @size == 0
    end

    def delete (key)
      previous = current = @first
      until current.nil? or current.key == key # stop until we find the key or reach the end
        previous = current # maintain the successor of the node to delete
        current = current.next # advance to next node
      end

      unless current.nil? # if the key was found
        if @first == current # if the node to delete is the first one
          @first = @first.next # remove the head
        else # otherwise
          previous.next = current.next # remove the node
        end

        @size -= 1 # update the size
        @max_key = current.key if @max_key == key # update max if it was removed
      end
    end

    def delete_min
      @first = @first.next # the first node is the min value
    end

    def delete_max
      delete(@max_key)
    end

    def size (*args)
      return @size if args.nil? or args.empty?

      lo, hi = *args
      size_counter = 0
      current = @first
      until current.nil? or current.key > hi # loop until a node outside the higher bound is found
        size_counter += 1 if current.key >= lo # count if the node is inside the lower bound
        current = current.next # advance to the next node
      end

      size_counter
    end

    ######################### PRIVATE ####################################################
    private

    def get_node(current, key)
      # loop until the end or we find a key greater than or equal to our key
      current = current.next until current.nil? or current.key >= key
      # return nil if the key was not found
      return nil if current.nil? or current.key != key

      current # return the matching node
    end

    def keys_in (lo, hi)
      current = @first
      result = Utils::Queue.new

      until current.nil? or current.key > hi # loop until we iterate outside the bounds
        result.queue(current.key) if current.key >= lo # queue if its inside the bounds
        current = current.next # iterate to next element
      end

      result
    end

    # Puts a new member in the lineage, maintaining ascendant order.
    # @param [KeyValuePair] ancestral The first node in the lineage (smallest key)
    # @param [KeyValuePair] member The member to insert in the lineage
    def put_sorted(ancestral, member)
      return member if ancestral.nil? # return the member if the ancestral is nil

      # ancestor = successor = ancestral
      ancestor = successor = ancestral # prepare elements
      # loop until the end or ancestor element is found
      until successor.nil? or successor.key > member.key
        ancestor = successor # the ancestor
        successor = successor.next # the successor
      end

      member.next = successor # link the successor

      if ancestral == successor # if the ancestral is a successor of the member
        ancestral = member # the member should be the ancestral
      else # otherwise
        ancestor.next = member # link the ancestor to the member
      end

      ancestral # return the ancestral (smallest key)
    end

    class KeyValuePair
      attr_accessor :key, :value, :next

      def initialize (key, value, next_node = nil)
        @key = key
        @value = value
        @next = next_node
      end
    end
  end
end