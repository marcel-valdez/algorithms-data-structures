# encoding: utf-8

require_relative 'queue'

module Utils
  # Symbol table with string keys, implemented using a ternary search
  # trie (TST).
  # Remark: Can't use a key that is the empty string ""
  class TrieSymbolTable

    def initialize
      @size = 0
      @root = TrieNode.new
    end

    include Enumerable

    # @return [Fixnum] number of key-value pairs
    def size
      @size
    end

    # Is string key in the symbol table?
    def contains?(key)
      not get(key).nil?
    end

    # @return [Object] Get value associated with a given key
    def get(key)
      node= get_node(@root, key, 0)
      return nil if node.nil?
      node.value
    end

    # Insert string s into the symbol table.
    def put(key, value)
      @root = put_node(@root, key, value, 0)
    end

    # Deletes the key-value pair from the Trie matching the given key
    def delete(key)

    end

    # @return [Enumerable] all keys in symbol table
    def keys
    end

    # @return [String] Find and return longest prefix of s in TST
    def longest_prefix_of
    end

    # @return [Enumerable] all keys starting with given prefix
    def prefix_match
    end

    def each
    end

    # @return [Enumerable] all keys in subtrie rooted at x with given prefix
    def collect
    end

    # @return [Enumerable] all keys matching given wilcard pattern
    def wildcard_match
    end

    private
    def put_node(node, key, value, idx)
      node = TrieNode.new if node.nil?
      if idx == key.length
        node.value = value
        @size += 1
        return node
      end

      sub_key = key[idx].ord
      node.next[sub_key] = put_node(node.next[sub_key], key, value, idx + 1)

      node
    end

    def get_node(node, key, idx)
      return nil if node.nil?
      return node if key.size == idx
      sub_key = key[idx].ord
      get_node(node.next[sub_key], key, idx + 1)
    end

    class TrieNode
      attr_accessor :value, :next

      def initialize(size = 256)
        @next = Array.new size
      end
    end
  end
end
