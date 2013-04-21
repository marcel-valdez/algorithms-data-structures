# encoding: utf-8

require_relative 'queue'

module Utils
  class BinarySearchTree

    def initialize
      @root = nil
    end

    include Enumerable

    # Put key-value pair into the tree
    # (remove key from the table if value is null)
    # @param [Object] key
    # @param [Object] value
    def put(key, value)
      @root = put_node(@root, key, value)
    end

    # @param [Object] key to find
    # @return [Object] Value paired with key, null if key is absent
    def get(key)
      get_value(@root, key)
    end

    # Gets the number of key-value pairs with a key less than the given key
    # The given key doesn't necessarily have to correspond to a key-value pair
    # @param [Object] key
    # @return [Fixnum] the number of keys less than the given key
    def rank(key)
      node_rank(@root, key)
    end

    # Gets the smallest key
    # @return [Object] The smallest key
    def min
      return nil if @root.nil?

      min_node(@root).key
    end

    # Gets the largest key
    # @return [Object] The largest key
    def max
      return nil if @root.nil?

      max_node(@root).key
    end

    # Gets the largest key less than or equal to key
    # @return [Object] The largest key less than or equal to the key
    # @param [Object] key
    def floor(key)
      node_floor(@root, key)
    end

    # Gets the smallest key greater than or equal to key
    def ceiling(key)
      node_ceiling(@root, key)
    end

    # Gets the key of the given rank
    # @param [Object] rank
    def select(rank)
      return min if rank == 0
      return nil if rank >= size

      select_node(@root, rank)
    end

    # Deletes the smallest key
    def delete_min
      @root = delete_min_node(@root)
    end

    # Deletes the largest key
    def delete_max
      @root = delete_max_node(@root)
    end

    # @param [Object] key Remove key (and its value) from the tree
    def delete(key)
      @root = delete_node(@root, key)
    end

    # @param [Object] key Is there a value paired with key?
    # @return [Boolean] true if it has a paired value, false otherwise.
    def contains?(key)
      !get(key).nil?
    end

    # @return [Boolean] Is the tree empty?
    def is_empty?
      size == 0
    end

    # Gets the number of key-value pairs in the range. If no parameter is given,
    # it counts all the keys.
    # parameters: lo, hi. Example: size(1,5), counts all the keys greater than
    # or equal to 1, and all keys less than or equal to 5.
    # Giving no parameters is equivalent to: size(min, max)
    # @return [Fixnum] Number of key-value pairs in the range.
    def size(*args)
      return range_size(@root, args[0], args[1]) unless args.nil? or args.empty?

      node_size(@root)
    end

    # Gets all the keys in a given range. If no parameter is given, it gets
    # all the keys.
    # Parameters: lo, hi. Example: keys(1, 5), gets all the keys less than
    # or equal to 5 and greater than or equal to 1.
    # Giving no parameters is equivalent to: keys(min, max)
    # @return [Object] All the keys in the range
    def keys(*args)
      result = Utils::Queue.new

      if args.nil? or args.empty?
        node_keys(@root, result)
      else
        range_keys(@root, result, args[0], args[1])
      end

      result
    end

    def each(&block)
      # in order
      unless @root.nil?
        each_node(@root, &block)
      end
    end

    def to_s
      node_to_s(@root)
    end

    #########################################################################
    private

    def node_to_s(node)
      return "empty" if node.nil?
      queue = Utils::Queue.new
      queue.queue node
      res = ""
      depth = 0
      count = []
      count[depth] = 1
      until queue.size == 0
        current = queue.dequeue
        res += current.to_s

        unless current.left.nil?
          queue.queue current.left
          count[depth + 1] = 0 if count[depth + 1].nil?
          count[depth + 1] += 1
          res += "l"
        end

        unless current.right.nil?
          queue.queue current.right
          count[depth + 1] = 0 if count[depth + 1].nil?
          count[depth + 1] += 1
          res+="r"
        end

        count[depth] -= 1
        if count[depth] == 0
          res += "\n"
          depth += 1
        end
      end

      res
    end

    def node_rank(node, key)
      return 0 if node.nil?

      comparison = key <=> node.key
      if comparison < 0 then
        return node_rank(node.left, key)
      end
      if comparison > 0 then
        return 1 + node_size(node.left) + node_rank(node.right, key)
      end

      node_size(node.left)
    end

    def select_node(current, rank)
      return nil if current.nil?

      current_rank = node_size(current.left)

      if current_rank > rank then
        return select_node(current.left, rank)
      end
      if current_rank < rank then
        return select_node(current.right, rank-current_rank-1)
      end

      current.key
    end

    def node_ceiling(node, key)
      return nil if node.nil? # no key less than or equal was found

      comparison = node.key <=> key

      if comparison < 0 # if current key is less
        return node_ceiling(node.right, key) # keep looking for larger key
      elsif comparison > 0 # if current key is greater
        tmp = node_ceiling(node.left, key) # look for a closer key
        return tmp if not tmp.nil? # return result if a closer key was found
      end

      node.key
    end

    def node_floor(node, key)
      return nil if node.nil? # no key less than or equal was found

      comparison = node.key <=> key

      if comparison > 0 # if current key is greater
        return node_floor(node.left, key) # keep looking for a smaller key
      elsif comparison < 0 # if current key is less
        tmp = node_floor(node.right, key) # look for a bigger key
        return tmp if not tmp.nil? # return result if a closer key was found
      end # if the node's key is equal to the given key

      node.key # return the key
    end

    def node_keys(node, queue)
      return if node.nil?

      node_keys(node.left, queue)
      queue.queue(node.key)
      node_keys(node.right, queue)
    end

    def delete_node(node, key)
      return nil if node.nil?

      comparison = key <=> node.key

      if comparison < 0 # key to delete is smaller than node's key
        node.left = delete_node(node.left, key)
      elsif comparison > 0 # key to delete is greater than node's key
        node.right = delete_node(node.right, key)
      else # node is the one we want to delete
        return node.left if node.right.nil?
        return node.right if node.left.nil?

        tmp = node
        if rand(2) == 0
          node = min_node(tmp.right)
          node.right = delete_min_node(tmp.right)
          node.left = tmp.left
        else
          node = max_node(tmp.left)
          node.left = delete_max_node(tmp.left)
          node.right = tmp.right
        end
      end

      node.size = node_size(node.left) + 1 + node_size(node.right)

      node
    end

    def max_node(node)
      return nil if node.nil?

      current = node
      until current.right.nil?
        current = current.right
      end

      current
    end

    def min_node(node)
      return nil if node.nil?

      current = node
      until current.left.nil?
        current = current.left
      end

      current
    end

    def delete_max_node(node)
      return node.left if node.right.nil?

      node.right = delete_max_node(node.right)
      node.size = node_size(node.left) + 1 + node_size(node.right)

      node
    end

    def delete_min_node(node)
      return node.right if node.left.nil?

      node.left = delete_min_node(node.left)
      node.size = node_size(node.left) + 1 + node_size(node.right)

      node
    end

    def range_size(node, lo, hi)
      return 0 if node.nil?

      lo_compare = lo <=> node.key
      hi_compare = hi <=> node.key

      count = 0
      if lo_compare < 0 # if key is greater than lower bound
                        # then the key is inside the lower boundary
        count = range_size(node.left, lo, hi)
      end

      if lo_compare <= 0 and hi_compare >= 0 # if key is between both bounds
                                             # then the key is inside both boundaries
        count += 1
      end

      if hi_compare > 0 # if key is greater than the higher bound
        count += range_size(node.right, lo, hi)
      end

      count
    end

    def range_keys(node, queue, lo, hi)
      return if node.nil?

      lo_compare = lo <=> node.key
      hi_compare = hi <=> node.key

      if lo_compare < 0 then
        range_keys(node.left, queue, lo, hi)
      end
      if lo_compare <= 0 and hi_compare >= 0 then
        queue.queue node.key
      end
      if hi_compare > 0 then
        range_keys(node.right, queue, lo, hi)
      end
    end

    # @param [BSTNode] node
    def node_size(node)
      return 0 if node.nil?
      node.size
    end

    def get_value(node, key)
      return nil if node.nil?
      cmp = key <=> node.key
      return get_value(node.left, key) if cmp < 0
      return get_value(node.right, key) if cmp > 0

      node.value
    end

    def put_node(node, key, value)
      return BSTNode.new(key, value, 1) if node.nil?

      cmp = key <=> node.key
      node.left = put_node(node.left, key, value) if cmp < 0
      node.right = put_node(node.right, key, value) if cmp > 0
      node.value = value if cmp == 0
      node.size = node_size(node.left) + 1 + node_size(node.right)

      node
    end

    def each_node(node, &block)
      return if node.nil?

      each_node node.left, &block
      block.call(node)
      each_node node.right, &block
    end

    class BSTNode
      attr_accessor :left, :right, :key, :value, :size

      def initialize(key, value, size)
        @left = nil
        @right = nil
        @key = key
        @value = value
        @size = size
      end

      def to_s
        "{ key:#@key, value:#@value }"
      end
    end
  end
end