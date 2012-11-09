require_relative "list_node"

module Utils
  class Stack
    include Enumerable

    attr_reader :size

    def initialize
      @size= 0
      @first= nil
    end

    def is_empty?
      @size == 0
    end

    def push (value)
      new_node = ListNode.new value
      new_node.next = @first
      @first = new_node

      @size += 1
    end

    def pop
      return nil if @first.nil?

      result = @first
      @first = @first.next

      @size -= 1

      result.value
    end

    def peek
      return nil if @first.nil?
      @first.value
    end

    def each
      current = @first
      until current.nil?
        yield current.value
        current = current.next
      end
    end

    private
    attr_accessor :first
    attr_writer :size
  end

end
