# encoding: utf-8

require 'test/unit'
require_relative '../../../src/chapter_1/section_3/linked_list_exercises'
require_relative '../../test_helper'
require_relative '../../../src/utils/linked_list'
require_relative '../../../src/utils/list_node'

module Chapter1
  module Section3
  # This class contains the tests for the LinkedListExercises class.
  # These tests help you cement your understanding on the linked list data
  # structure.
    class LinkedListExercisesTest < TestHelper

      def initialize(*args)
        super(*args)
      end

      def setup
        @target = LinkedListExercises.new
      end

      # Write a method e31_delete that takes an int argument k and deletes
      # the kth element in a linked list, if it exists.
      def test_e31_delete
        root = Utils::ListNode.new('1')
        list = Utils::LinkedList.new(root)
        create_list(list, '2', '3', '4', '5', '6')

        root2 = Utils::ListNode.new('1')
        list2 = Utils::LinkedList.new(root2)
        create_list(list2, '2', '3', '4', '5', '6')

        root3 = Utils::ListNode.new('1')
        list3 = Utils::LinkedList.new(root3)
        create_list(list3, '2', '3', '4', '5', '6')

        verify_method :e31_delete,
                      :with =>
                          [
                              {params: [root, '5'], predicate: Proc.new { check_delete('5', root) }},
                              {params: [root2, '4'], predicate: Proc.new { check_delete('4', root2) }},
                              {params: [root3, '7'], predicate: Proc.new { check_delete('7', root3) }},
                          ]

      end

      # Write a method e32_find that takes a linked list and a string key as arguments
      # and returns true if some node in the list has key as its item field, false otherwise.
      def test_e32_find

        root = Utils::ListNode.new('1')
        list = Utils::LinkedList.new(root)
        create_list(list, '2', '3', '4', '5', '6')

        #end
        verify_method :e32_find,
                      :with =>
                          [
                              {params: [root, '5'], expect: true},
                              {params: [root, '4'], expect: true},
                              {params: [root, '1'], expect: true},
                              {params: [root, '2'], expect: true},
                              {params: [root, '9'], expect: false},
                              {params: [root, '-1'], expect: false},
                              {params: [root, '100'], expect: false}
                          ]
      end

      # Write a function e33_reverse_recur that takes the first Node in a linked list as
      # argument and (destructively) reverses the list, returning the first Node in the result.
      # Use recursion.
      def test_e33_reverse_recur
        check_reverse_linked_list :e33_reverse_recur
      end

      # Write a function e33_reverse_iter that takes the first Node in a linked list as
      # argument and (destructively) reverses the list, returning the first Node in the result.
      # Use iteration without recursion.
      def test_e33_reverse_iter
        check_reverse_linked_list :e33_reverse_iter
      end

      private

      # Helps test the linked list reversal algorithm behavior
      def check_reverse_linked_list(method_sym)
        root = Utils::ListNode.new('1')
        root2 = Utils::ListNode.new('1')
        list = Utils::LinkedList.new(root)
        list2 = Utils::LinkedList.new(root2)
        create_list(list, '2', '3', '4')
        reversed_list = Array['4', '3', '2', '1']
        create_list(list2, '2', '3', '5')
        reversed_list2 = Array['5', '3', '2', '1']

        verify_method method_sym,
                      :with =>
                          [{
                               param: root,
                               predicate: Proc.new { |new_root|
                                 check_list(new_root, reversed_list)
                               }
                           },
                           {
                               params: root2,
                               predicate: Proc.new { |new_root|
                                 check_list(new_root, reversed_list2)
                               }
                           },
                          ]
      end

      def check_delete(input, node)
        node = node.next until node.nil? or node.value == input
        node.nil?
      end

      def create_list(list, *args)
        args.each { |node| list.add(Utils::ListNode.new(node)) }
      end

      def check_list(node, arr)
        i=0
        until node.nil? or arr[i] != node.value
          node = node.next
          i+=1
        end

        i == arr.length
      end

    end
  end
end
