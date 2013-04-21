# encoding: utf-8

require_relative '../test_helper'
require_relative '../../src/utils/bag'
require_relative 'utils_test_helper'

module Utils
  class BagTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= Bag.new
    end

    def test_api_definition
      # Arrange
      api = [:is_empty?, :size, :insert]
      non_api = [:size=, :first=, :first]

      # Act
      @target=Bag.new

      # Assert
      assert_api(api, non_api)
    end

    def test_it_starts_empty
      # Arrange

      # Act
      target = Bag.new

      # Assert
      assert_true target.is_empty?
    end

    def test_it_adds_first_node
      # Arrange
      target = Bag.new

      # Act
      target.insert 1

      # Assert
      assert_false target.is_empty?
      assert_equal 1, target.size

      sub_case 'test if it can add a second node' do
        # Act (2nd)
        target.insert 2

        # Assert
        assert_equal 2, target.size
        assert_false target.is_empty?
      end

      sub_case 'test if it can traverse the nodes' do
        # Arrange
        i = 2

        # Act (3th)
        target.each { |item|
          # Assert
          assert_equal i, item
          i-=1
        }
      end
    end
  end
end