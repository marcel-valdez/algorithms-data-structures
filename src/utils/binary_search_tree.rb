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

    # @param [Object] key Remove key (and its value) from the tree
    def delete(key)
    end

    # @param [Object] key Is there a value paired with key?
    # @return [Boolean] true if it has a paired value, false otherwise.
    def contains(key)
    end

    # @return [Boolean] Is the tree empty?
    def is_empty?
      size == 0
    end

    # @return [Fixnum] Number of key-value pairs in the table.
    def size
      node_size(@root)
    end

    # @return [Object] All the keys in the table
    def keys
    end


    def each(&block)
      # in order
      unless @root.nil?
        each_node(@root, &block)
      end
    end

    private

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