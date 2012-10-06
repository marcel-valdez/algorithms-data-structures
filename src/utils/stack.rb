class Stack
  attr_reader :first, :last, :size

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
    result = @first
    @first = @first.next

    @size -= 1

    result
  end

  private
  attr_writer :first, :last, :size

  class Node
    attr_accessor :value, :next

    def initialize (value)
      @value=value
      @next=nil
    end
  end
end

