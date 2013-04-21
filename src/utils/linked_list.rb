# encoding: utf-8

module Utils
  class LinkedList
    include Enumerable

    def initialize(node)
      @count = 1
      @first = @last = node
    end

    def add(node)
      @count += 1
      @last.next = node
      @last = node
    end

    # TODO: add test for this
    def remove(node)
      previous = current = @first

      until current.nil? or current.eql? node
        previous = current
        current = current.next
      end

      unless current.nil?
        previous.next = current.next
      end
    end

    # TODO: add test for this
    def each
      current = @first
      until current.nil?
        yield current.value
        current = current.next
      end
    end

    # TODO: add test for this
    def to_s
      if @last.nil?
        puts('Empty list')
      else
        puts "Found #{@count} items..."
        slider = @last

        while slider.next != nil
          puts slider.value
          slider = slider.next
        end

        puts slider.value
      end #if-else ends
    end #print ends
  end #class List end
end
