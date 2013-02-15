# encoding: utf-8

require_relative "../../utils/point2d"
require_relative "../../utils/number_utils"
require_relative "../../utils/linked_list"

module Chapter1
  module Section3
    class LinkedListExercises

      def initialize

      end

      # Write a method e31_delete() that takes an int argument k and deletes the kth
      # element in a linked list, if it exists.
      # Assume input is always a string
      # Examples:
      def e31_delete(node, input)
        while node.next != nil
          if node.value == input
            node.value = node.next.value
            node.next = node.next.next
          else
            node = node.next
          end
        end #while ends
      end

      # Write a method find() that takes a linked list and a string key as
      # arguments and returns true if some node in the list has key as its item field, false otherwise.
      # Assume input is always a string
      def e32_find(node, input)
        while node.next != nil
          if node.value == input
            return true
          end
          node = node.next
        end
        return false
      end

      # Write a function e33_reverse_iter that takes the first Node
      # in a linked list as argument and (destructively) reverses the
      # list, returning the first Node in the result.
      # Use iteration.
      def e33_reverse_iter(root)
        previous_node = nil
        current = root
        while current != nil
          next_node = current.next
          current.next = previous_node
          previous_node = current
          current = next_node
        end

        return previous_node
      end

      # Write a function e33_reverse_recur that takes the first Node
      # in a linked list as argument and (destructively) reverses the
      # list, returning the first Node in the result.
      # Use recursion.
      def e33_reverse_recur(node)
        # guard clause to validate input
        return nil if node.nil?
        # the node is the new root if its the end of the list
        return node if node.next.nil?

        # get the next node
        next_node = node.next

        # reverse the rest of the nodes
        rest = e33_reverse_recur(next_node)
        # reverse the current pair of nodes
        next_node.next = node
        # set node as the new tail
        node.next = nil

        # return the new root
        return rest
      end

    end
  end
end
