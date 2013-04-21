# encoding: utf-8

require_relative '../../test/test_helper'
require_relative '../lib/test_extractor'

module Tools
  module Tests
    # Contains the unit tests for the TestExtractor class
    class TestExtractorTest < TestHelper
      # Initializes a test instance
      def initialize(arg)
        super(arg)
      end

      # arrange
      [
          ['Test that it extracts a single test',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_something
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_something
      omit(\'Yet to see the light.\')
    end
  end
end'
          ],
          ['Test that it does not confuse test_ with no def',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_something
      test_x = \'x\'
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_something
      omit(\'Yet to see the light.\')
      test_x = \'x\'
    end
  end
end'
          ],
          ['Test that it identifies all test name characters',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_aA1_
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_aA1_
      omit(\'Yet to see the light.\')
    end
  end
end'
          ],
          ['Test that it strips multiple test methods',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_1
    end

    # comment for simple method
    def test_2
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_1
      omit(\'Yet to see the light.\')
    end

    # comment for simple method
    def test_2
      omit(\'Yet to see the light.\')
    end
  end
end',
          ],
          ['Test that it ignores def test_x in comments',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    # def test_0
    def test_1
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    # def test_0
    def test_1
      omit(\'Yet to see the light.\')
    end
  end
end'
          ],
          ['Test that it ignores def test_x in strings',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_1
      "  def test_x"
      \'  def test_x \'
      "\'  def test_x \'"
      "\'  def test_x "\'
      "\'"  def test_x \'"
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_1
      omit(\'Yet to see the light.\')
      "  def test_x"
      \'  def test_x \'
      "\'  def test_x \'"
      "\'  def test_x "\'
      "\'"  def test_x \'"
    end
  end
end'
          ],
          ['Test that it ignores def test_x in multi-line strings',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_1
      var x =  \'
      def test_x
      \'
    end
  end
end',
           'module Tests
  # Just a stub test class
  class MyTest < TestHelper
    # comment for simple method
    def test_1
      omit(\'Yet to see the light.\')
      var x =  \'
      def test_x
      \'
    end
  end
end'
          ]
      ].each { |name, content, expected_content|
        test "that it extracts correctly:\n
             #{name}" do
          target = TestExtractor.new
          # act
          actual_content = target.strip_content(content)

          # assert
          assert_equal expected_content, actual_content, name
        end
      }

      [
          ['Simple open single quote', "'", :single],
          ['Simple open double quote', '"', :double],
          ['Simple closed single quote', "''", nil],
          ['Simple closed double quote', '""', nil],
          ['Single quoted closed double quote', '"\'"', nil],
          ['Double quoted closed single quote', "'\"'", nil],
          ['Triple single open quote', "''+'", :single],
          ['Triple double open quote', '""+"', :double],
          ['Pre-close single quote', "'", nil, :single],
          ['Pre-close double quote', '"', nil, :double],
          ['In comment closed double quote', '#"', nil, nil],
          ['In comment closed single quote', "#'", nil, nil],
          ['Mid comment simple closed single quote', "'#'", nil],
          ['Mid comment simple closed double quote', '"#"', nil],
          ['Mid comment closed double quote', '""#"', nil, nil],
          ['Mid comment closed single quote', "''#'", nil, nil],
          ['Mid comment prev closed double quote', '"#"', nil, :double],
          ['Mid comment prev closed single quote', "'#'", nil, :single],
      ].each { |name, line, expect, previous|
        test "if it determines multiline correctly:\n
             #{name}" do
          # arrange
          target = TestExtractor.new
          # act
          actual = target.is_multiline?(line, previous)
          # assert
          assert_equal expect, actual, name
        end
      }
    end
  end
end