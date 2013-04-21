# encoding: utf-8

require 'fileutils'
require_relative '../../test/test_helper'
require_relative '../lib/folder_extractor'
require_relative '../lib/exercise_extractor'
require_relative 'mock/mock_file_sys'

module Tools
  module Tests

    # Contains the unit tests for the FolderExtractor class
    class FolderExtractorTest < TestHelper
      # initializes this test instance
      def initialize (arg)
        super(arg)
      end


      test 'integration of FolderExtractor and ExerciseExtractor' do
        # arrange
        begin
          dst_dir = 'temp'
          target = FolderExtractor.new(ExerciseExtractor.new)
          src_dir = 'data'
          # act
          target.extract(src_dir, dst_dir)
          # assert
          assert_path_exist 'temp/my_class.rb'
          assert_path_exist 'temp/my_other_class.rb'
          assert_path_not_exist 'temp/some_not.rb.txt'
          assert_path_exist 'temp/inner'
          assert_path_exist 'temp/inner/my_inner_class.rb'

          check_file_content(
              'temp/my_class.rb',
              '# This is my class
class MyClass
  # Test that multiple methods get stripped
  def my_method
  end

  # Test that multiple methods get stripped
  def my_other_method
  end
end')
          check_file_content(
              'temp/my_other_class.rb',
              '# Multiple classes in single directory
# class without any methods (just to check it does not break)
def MyOtherClass
end')
          check_file_content(
              'temp/inner/my_inner_class.rb',
              'module Inner
  # Class inside a directory (recursion necessary)
  class MyInnerClass
    # Single method
    def my_inner_method
    end
  end
end')
        ensure
          FileUtils.rmtree 'temp' if File.exists? 'temp'
        end
      end

      # Tests that the extractor fails when sent a file path
      # that does not exist in the 'from' argument.
      test 'fail when non existing from argument is given' do
        # arrange
        dir = 'bad_dir'
        file_sys = make_file_sys(dir, true)
        target = FolderExtractor.new(nil, file_sys)

        # assert-act
        assert_raise_message('bad_dir does not exist.') {
          target.extract(dir, Dir.getwd)
        }
      end

      # Tests that the extractor does not fails when sent a file path
      # that does not exist in the 'to' argument.
      test 'not fail when non existing "to" argument is given' do

        # arrange
        dir = 'bad_dir'
        file_sys = make_file_sys(dir, true)
        target = FolderExtractor.new(nil, file_sys)

        # assert-act
        target.extract(Dir.getwd, dir)
      end

      test 'fail when "from" is not a directory' do
        # arrange
        dir = 'bad_dir'
        file_sys = make_file_sys(dir, false, true)
        target = FolderExtractor.new(nil, file_sys)

        # assert-act
        assert_raise_message('bad_dir is not a directory.') {
          target.extract(dir, Dir.getwd)
        }
      end

      test 'not fail when "to" is not a directory' do
        # arrange
        dir = 'bad_dir'
        file_sys = make_file_sys(dir, false, true)
        target = FolderExtractor.new(nil, file_sys)

        # assert-act
        target.extract(Dir.getwd, dir)
      end

      test 'that it reads, strips and writes correctly' do
        # arrange
        expected_content = 'content'
        expected_path = 'some/dir/file.rb'
        dst_dir = 'some/dir'
        file_path = 'other/file.rb'
        extractor = Object.new
        file_sys = MockFileSys.new
        target = FolderExtractor.new(extractor, file_sys)

        # record
        extractor.send(:instance_eval) {
          def strip_content(content)
            content
          end
        }

        file_sys.set_read_file { |path| expected_content }
        file_sys.set_get_basename { |file_path| 'file.rb' }
        file_sys.set_write_file { |content, file_path|
          assert_equal content, expected_content
          assert_equal file_path, expected_path
        }

        # play
        target.strip_file(file_path, dst_dir)
      end

      test 'that it strips all .rb files' do
        # arrange
        from_dir = 'from/dir'
        to_dir = 'to/dir'
        files = %w(file1.rb file2.rb file3.rb.txt file4.yml)
        expected_files = %w(from/dir/file1.rb from/dir/file2.rb)
        file_sys = MockFileSys.new
        target = FolderExtractor.new(Object.new, file_sys)
        target.send(:instance_eval) {
          # parameter for mock testing
          def src_files
            @src_files
          end

          # parameter for mock testing
          def to_dir
            @dst_dir
          end

          # mocked method for testing
          def strip_file(file, to)
            @src_files = [] if @src_files.nil?

            @src_files.push file
            @dst_dir = to
          end
        }

        file_sys.set_get_subdirs { |dir| [] }
        file_sys.set_get_files { |dir| files }
        file_sys.set_is_dir? { |x| true }
        file_sys.set_exists? { |x| true }

        # act
        target.extract(from_dir, to_dir)

        # assert
        assert_equal to_dir, target.to_dir
        assert_equal expected_files, target.src_files
      end

      test 'that it calls itself recursively' do
        # arrange
        from_dir = 'from/dir'
        to_dir = 'to/dir'
        depth = 0
        dirs = [%w(dir_0_1 dir_0_2), %w(dir_0_1_1)]
        actual_froms = []
        expected_froms = %w(
        from/dir
        from/dir/dir_0_1
        from/dir/dir_0_1/dir_0_1_1
        from/dir/dir_0_2)
        actual_tos = []
        expected_tos = %w(
        to/dir
        to/dir/dir_0_1
        to/dir/dir_0_1/dir_0_1_1
        to/dir/dir_0_2)
        file_sys = MockFileSys.new
        target = FolderExtractor.new(Object.new, file_sys)

        file_sys.set_get_subdirs { |dir|
          actual_froms.push dir
          result = dirs[depth]
          depth+=1
          result.nil? ? [] : result
        }

        file_sys.set_mkdir { |dir| actual_tos.push dir }
        file_sys.set_get_files { |dir| [] }
        file_sys.set_is_dir? { |x| true }
        file_sys.set_exists? { |x| true }

        # act
        target.extract(from_dir, to_dir)

        # assert
        assert_equal expected_froms, actual_froms
        assert_equal expected_tos, actual_tos
      end

      # Makes a stub file_sys object
      def make_file_sys(dir, only_dir_exist = false, only_dir_is = false)
        file_sys = MockFileSys.new
        file_sys.set_exists? { |x| !only_dir_exist or !x.eql? dir }
        file_sys.set_is_dir? { |x| !only_dir_is or !x.eql?(dir) }
        file_sys
      end

      # Checks tha a file has the expected content.
      def check_file_content(file_path, my_class_expected)
        assert_equal File.read(file_path), my_class_expected
      end
    end
  end
end
