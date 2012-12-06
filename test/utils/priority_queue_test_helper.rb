# encoding: utf-8

module Utils
  module PriorityQueueTestHelper

    # Checks that calling insert on the @target increases
    # it's size by 1.
    def check_insert_increases_size
      @target = create_target()

      # Act
      @target.insert(1)

      # Assert
      assert_equal 1, @target.size

      # Clean
      @target = nil
    end

    # Sets up the @target priority queue with
    # the given keys
    # @param [Array] keys
    def setup_heap(*keys)
      target = create_target()
      keys.flatten!
      keys.each { |key| target.insert key }

      target
    end

    # Checks that the priority queue can enumerate all
    # keys, in the same order as the received array
    # @param [Array] keys
    def check_key_enumeration(keys)
      @target = setup_heap(keys.shuffle)

      # Act
      i = 0
      @target.each { |key|
        # Assert
        assert_equal keys[i], key
        i += 1
      }

      assert_equal i, keys.length
      # each should not change the size
      assert_equal keys.length, @target.size

      # Clean
      @target = nil
    end

    # Checks that calling the delete_method on the @target,
    # continuously will empty the @target.
    # @param [Symbol] delete_method
    # @param [Symbol] key_getter
    # @param [Array] keys
    def check_delete_until_empty(delete_method, key_getter, keys)
      @target = setup_heap(keys.shuffle)
      until @target.is_empty? do
        actual = @target.send(delete_method)

        # Assert
        assert_equal keys.send(key_getter), actual
        keys.delete(actual)
      end

      # Clean
      @target = nil
    end

    # Checks that the @target can delete the expected
    # key and return it, as well as reduce it's size by 1.
    # @param [Symbol] delete_method
    # @param [Object] expected
    # @param [Array] keys
    def check_can_delete(delete_method, expected, keys)
      @target = setup_heap(keys.shuffle)

      # Act
      actual = @target.send(delete_method)

      # Assert
      assert_equal expected, actual
      assert_equal (keys.length - 1), @target.size

      # Clear
      @target = nil
    end

    # Checks that the @target can get the expected key, using
    # the key_getter method, and having the keys as its data.
    # @param [Object] expected
    # @param [Symbol] key_getter
    # @param [Array] keys
    def check_get_key(expected, key_getter, keys)
      @target = setup_heap(keys)

      # Act
      actual = @target.send(key_getter)

      # Assert
      assert_equal expected, actual
      assert_equal keys.length, @target.size

      # Clean
      @target = nil
    end
  end
end