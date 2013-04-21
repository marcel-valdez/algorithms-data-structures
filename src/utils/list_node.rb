# encoding: utf-8

module Utils
  class ListNode
    attr_accessor :value, :next

    def initialize (value, next_node = nil)
      @value=value
      @next=next_node
    end

    def inspect
      to_s
    end

    def to_s
      next_value = @next.nil? ? "nil" : @next.value
      "<#@value next:#{next_value}>"
    end
  end
end