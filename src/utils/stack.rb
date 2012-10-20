module Utils
  class Stack
    include Enumerable

    attr_reader :size

    def initialize
      @size= 0
      @first= nil
      @last= nil
    end

    def is_empty?
      @size == 0
    end

    def push (value)
      new_node = Node.new value
      new_node.next = @first
      @first = new_node

      @last = @first if @size == 0

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
    attr_accessor :first, :last
    attr_writer :size

    class Node
      attr_accessor :value, :next

      def initialize (value)
        @value=value
        @next=nil
      end
    end
  end

end
