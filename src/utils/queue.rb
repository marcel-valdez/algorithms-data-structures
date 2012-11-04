module Utils
  class Queue
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

    def queue (value)
      new_node = Node.new value
      if @size == 0
        @first = @last = new_node
      else
        @last = @last.next = new_node
      end

      @size += 1
    end

    def dequeue
      return nil if @first.nil?

      result = @first.value

      @first = @first.next
      @size -= 1

      @last = nil if @size == 0

      result
    end

    # TODO: Needs tests
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
