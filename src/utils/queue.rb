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
      @last.next = new_node unless @last.nil?
      @last = new_node
      @first = @last if @size == 0

      @size += 1
    end

    def dequeue
      result = @first
      @first = @first.next
      @size -= 1

      @last = @first if @size == 0

      result.value
    end

    def each
      current = @first
      unless current.nil?
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