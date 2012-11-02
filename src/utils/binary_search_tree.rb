# encoding: utf-8

module Utils
  class BinarySearchTree

    def initialize
      @size = 0
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

    # Gets the number of keys less than the given key
    # @param [Object] key
    # @return [Fixnum] the number of keys less than the given key
    def rank(key)

    end


    # Gets the smallest key
    # @return [Object] The smallest key
    def min
      min_node(@root)
    end

    # Gets the largest key
    # @return [Object] The largest key
    def max
      max_node(@root)
    end

    # Gets the largest key less than or equal to key
    # @return [Object] The largest key less than or equal to the key
    # @param [Object] key
    def floor(key)

    end

    # Gets the smallest key greater than or equal to key
    def ceiling(key)

    end

    # Gets the key of the given rank
    # @param [Object] rank
    def select(rank)

    end

    # Deletes the smallest key
    def delete_min
      delete_min_node(@root)
    end

    # Deletes the largest key
    def delete_max
      delete_max_node(@root)
    end

    # @param [Object] key Remove key (and its value) from the tree
    def delete(key)
      delete_node(@root, key)
    end

    # @param [Object] key Is there a value paired with key?
    # @return [Boolean] true if it has a paired value, false otherwise.
    def contains(key)
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
      return range_size(args[0], args[1]) unless args.nil? or args.empty?

      node_size(@root)
    end

    # Gets all the keys in a given range. If no parameter is given, it gets
    # all the keys.
    # Parameters: lo, hi. Example: keys(1, 5), gets all the keys less than
    # or equal to 5 and greater than or equal to 1.
    # Giving no parameters is equivalent to: keys(min, max)
    # @return [Object] All the keys in the range
    def keys(*args)
      return range_keys(args[0], args[1]) unless args.nil? or args.empty?

      result = ::Utils::Queue.new
      node_keys(@root, result)

      result
    end

    def node_keys(node, queue)
      return if node.nil?

      node_keys(node.left, queue)
      queue.queue(node.key)
      node_keys(node.right, queue)
    end

    def each(&block)
      # in order
      unless @root.nil?
        each_node(@root, &block)
      end
    end

    private

    def delete_node(node, key)
      return nil if node.nil?
      comparison = key <=> node.key

      if comparison < 0 # key to delete is smaller than node's key
        node.left = delete_node(node.left, key)
      elsif comparison > 0 # key to delete is greater than node's key
        node.right = delete_node(node.right, key)
      else # node is the node we want to delete
        return node.left if node.right.nil?
        return node.right if node.left.nil?

        tmp = node
        if rand(2) == 0
          node = min_node(tmp.right)
          node.left = delete_max_node(tmp.left)
        else
          node = max_node(tmp.left)
          node.right = delete_min_node(tmp.right)
        end
      end

      node.size = node_size(node.left) + 1 + node_size(node.right)

    end

    def max_node(node)
      return nil if node.nil?

      key = node.key
      current = node.right
      until current.nil?
        key = current.key
        current = current.right
      end

      key
    end

    def min_node(node)
      return nil if node.nil?

      key = node.key
      current = node.left
      until current.nil?
        key = current.key
        current = current.left
      end

      key
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

    def range_size(lo, hi)

    end

    def range_keys(lo, hi)

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
      block(node.left)
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
    end
  end
end