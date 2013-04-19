# encoding: utf-8

require_relative '../../test/test_helper'
require_relative '../lib/exercise_extractor'

module Tools
  module Tests
    class ExerciseExtractorTest < TestHelper
      def initialize (arg)
        super(arg)
      end

      # Called before every test method runs. Can be used
      # to set up fixture information.
      def setup
        @target = ExerciseExtractor.new
      end

      # Tests that the extractor ignores attr_reader, attr_writer and attr_accessor
      test 'if it ignores attributes' do
        # arrange

        content = '# This is the test for the single method extraction test
        class SingleMethod
          attr_reader :reader
          attr_accessor :accessor

          attr_writer :writer, :other_writer
          # The exercise\s description
          def attr_reader
            puts "single_method"
          end
        end'

        expected = '# This is the test for the single method extraction test
        class SingleMethod

          # The exercise\s description
          def attr_reader
          end
        end'

        # act
        check_strip_methods content, expected
      end

      # Test a single method extraction
      test 'single method extraction' do
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

      # @param [String] content is the code to strip
      # @param [String] expected resulting code
      def check_strip_methods(content, expected)
        result = @target.strip_methods content
        # assert
        assert_equal expected, result
      end

      def test_attribute_detection
        verify_method :is_attribute?, with: [
            {param: '  attr_reader :a', expect: true},
            {param: '  attr_accessor :a1', expect: true},
            {param: '  attr_writer :a_a', expect: true},
            {param: '  attr_reader :a?', expect: true},
            {param: '  attr_accessor :a-', expect: true},
            {param: '  def attr_accessor :a', expect: false},
            {param: '  attr_accessor = :a', expect: false}
        ]
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