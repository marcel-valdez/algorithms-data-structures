# encoding: utf-8

require 'test/unit'
require_relative '../lib/exercise_extractor'
require_relative '../../test/test_helper'

module Tools
  module Tests
    class ExerciseExtractorTest < TestHelper

      # Called before every test method runs. Can be used
      # to set up fixture information.
      def setup
        @target = ExerciseExtractor.new
      end

      # Called after every test method runs. Can be used to tear
      # down fixture information.

      def teardown
        # Do nothing
      end

      # Test a single method extraction
      def test_method_extraction
        # arrange
        content = '# This is the test for the single method extraction test
        class SingleMethod
          # The exercise\s description
          def single_method
            puts "single_method"
          end
        end'

        expected = '# This is the test for the single method extraction test
        class SingleMethod
          # The exercise\s description
          def single_method
          end
        end'
        # act
        result = @target.strip_methods content
        # assert
        assert_equal expected, result
      end

      # Test a single method extraction
      def test_ignore_private_method
        # arrange
        content = '# This is the test for the private method extraction test
        class SingleMethod
          # The exercise\s description
          def single_method
            puts "single_method"
          end

          private
          def other_method
            puts "hi"
          end
        end'

        expected = '# This is the test for the private method extraction test
        class SingleMethod
          # The exercise\s description
          def single_method
          end

        end'
        # act
        result = @target.strip_methods content
        # assert
        assert_equal expected, result
      end

      def test_several_method_extraction
        # arrange
        content =
            '# This is the test file for the several method extraction test
        class SingleMethod
          # The exercise\s description
          def single_method
            a = 1 + 1
            return a + 3
          end

          # This is some exercise
          def some_exercise(arg1, arg2)
            return arg1 - arg2
          end
        end'

        expected =
            '# This is the test file for the several method extraction test
        class SingleMethod
          # The exercise\s description
          def single_method
          end

          # This is some exercise
          def some_exercise(arg1, arg2)
          end
        end'

        # act
        check_strip_methods(content, expected)
      end

      def check_strip_methods(content, expected)
        result = @target.strip_methods content
        # assert
        assert_equal expected, result
      end

      def test_method_detection
        verify_method :is_method?, with: [
            {param: '  def method_def', expect: true},
            {param: '  de method_def', expect: false},
            {param: '  def method1', expect: true},
            {param: '#  def method1', expect: false}
        ]
      end

      def test_get_method_end
        verify_method :get_method_end, with: [
            {param: '  def method', expect: "  end\n"},
            {param: ' def method', expect: " end\n"},
        ]
      end

      def test_is_private_keyword
        verify_method :is_private_keyword?, with: [
            {param: 'private', expect: true},
            {param: '  private', expect: true},
            {param: 'private  ', expect: true},
            {param: '  private  ', expect: true},
            {param: 'puts "  private  "', expect: false},
            {param: 'def  private_method  ', expect: false},
        ]
      end
    end
  end
end