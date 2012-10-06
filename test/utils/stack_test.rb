require_relative "../test_helper"
require_relative "../../src/utils/stack"
class StackTest < TestHelper
  def setup
    @target= Stack.new
  end

  test "It has API definition" do
    # Arrange
    api = [:is_empty?, :size, :push, :pop, :first, :last]
    non_api = [:size=, :first=, :last=]

    # Act
    target = Stack.new

    # Assert

    api.each { |method_name|
      assert_respond_to target, method_name
    }

    non_api.each { |method_name|
      assert_not_respond_to target, method_name
    }
  end

  test "Test it starts empty" do
    # Arrange

    # Act
    target = Stack.new

    # Assert
    assert_true target.is_empty?
  end

  test "Test if it can add first node" do
    # Arrange
    target = Stack.new

    # Act
    target.push 1

    # Assert
    assert_false target.is_empty?
    assert_equal 1, target.size
    assert_not_nil target.first
    assert_equal target.first, target.last
    assert_nil target.first.next

     sub_case "Test if it can add a second node" do
      # Act (2nd)
       target.push 2

      # Assert
       assert_equal 2, target.size
       assert_equal 2, target.first.value
       assert_not_equal target.first, target.last
       assert_equal target.first.next, target.last
       assert_nil target.last.next

       sub_case "Test if it can pop a node" do
         # Act (3rd)
         actual = target.pop

         # Assert
         assert_equal 1, target.size
         assert_equal target.first, target.last
         assert_nil target.first.next
         assert_not_nil actual
         assert_equal actual.value, 2
       end
    end
  end
end