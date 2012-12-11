# encoding: utf-8

require_relative "../test_helper"
require_relative "../../src/utils/trie_symbol_table"
require_relative "utils_test_helper"

module Utils
  class TrieSymbolTableTest < TestHelper
    include UtilsTestHelper

    def initialize(*arg)
      super(*arg)
      @target= nil
    end

    test "if it has correct API definition" do
      # Arrange
      api = [
        :size, :contains?, :get, :put, :longest_prefix_of,
        :each, :collect, :wildcard_match, :prefix_match, :keys,
        :delete
      ]
      non_api = [:size= ]

      # Act
      @target = TrieSymbolTable.new

      # Assert
      assert_api(api, non_api)
    end

    test "test if it is initialized correctly" do
      # Arrange
      @target = nil

      # Act
      @target = TrieSymbolTable.new

      # Assert
      assert_equal 0, @target.size

      # Clean
      @target = nil
    end

    test "test if it can put a new key-value (put/size/contains?)" do
      # Arrange
      @target = TrieSymbolTable.new

      # Act                                           shutdown -r noew
      @target.put("key", 1)
      value = @target.get("key")
      contained = @target.contains? "key"

      # Assert
      assert_equal 1, @target.size
      assert_equal 1, value
      assert contained

      # Clean
      @target = nil
    end

    test "test if it it can put several values and retrieve all" do
      raise "Finish coding Trie Symbol Table Utility"
      # Arrange
      @target = TrieSymbolTable.new
      
      # Act


      # Assert


      # Clean

    end
  end
end
