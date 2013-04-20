# encoding: utf-8

require_relative '../../test/test_helper'
require_relative '../lib/folder_extractor'
require_relative '../lib/exercise_extractor'

module Tools
  module Tests

    # Contains the unit tests for the FolderExtractor class
    class FolderExtractorTest < TestHelper

      def initialize (arg)
        super(arg)
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

      # Tests that the extractor fails when sent a file path
      # that does not exist in the 'to' argument.
      test 'fail when non existing "to" argument is given' do

        # arrange
        dir = 'bad_dir'
        file_sys = make_file_sys(dir, true)
        target = FolderExtractor.new(nil, file_sys)

        # assert-act
        assert_raise_message('bad_dir does not exist.') {
          target.extract(Dir.getwd, dir)
        }
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

      test 'fail when "to" is not a directory' do
        # arrange
        dir = 'bad_dir'
        file_sys = make_file_sys(dir, false, true)
        target = FolderExtractor.new(nil, file_sys)

        # assert-act

        assert_raise_message('bad_dir is not a directory.') {
          target.extract(Dir.getwd, dir)
        }
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
          def strip_methods(content)
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
    end

    # This is a mock class for the FileSys class, in order to
    # isolate from the filesystem.
    class MockFileSys
      # Determines whether the path exists.
      # @param [String] path is the file path
      # @return [Boolean] true if it exists, false otherwise
      def exists?(path)
        @exists_proc.call(path) unless @exists_proc.nil?
      end

      # Sets the procedure to callback when exists? is called.
      # param [Proc] block is the callback
      def set_exists?(&block)
        @exists_proc = block
      end

      # Gets the subdirectories in a given directory
      # @return [Array] the subdirectories in the directory path
      def get_subdirs(directory)
        @get_subdirs_proc.call(directory) unless @get_subdirs_proc.nil?
      end

      # Sets the procedure to callback when get_subdirs(directory)
      # is called.
      # @param [Proc] block is the callback
      def set_get_subdirs(&block)
        @get_subdirs_proc = block
      end

      # Gets non-directory files inside a directory
      # @return [Array] the non-directory files inside the given directory path
      def get_files(directory)
        @get_files_proc.call(directory) unless @get_files_proc.nil?
      end

      # Sets the procedure to callback when get_files(directory)
      # is called.
      # @param [Proc] block is the callback
      def set_get_files(&block)
        @get_files_proc = block
      end

      # Determines whether the specified path is a directory
      # @return [String] the path to a file
      def is_dir?(path)
        @is_dir_proc.call(path) unless @is_dir_proc.nil?
      end

      # Sets the procedure to callback when is_dir?(path)
      # is called.
      # @param [Proc] block is the callback
      def set_is_dir?(&block)
        @is_dir_proc = block
      end

      # Reads a file and returns its text contents
      # @return [String] reads the text contents of a file
      def read_file(path)
        @read_proc.call(path) unless @read_proc.nil?
      end

      # Sets the procedure to callback when read_file(path) is called
      # @param [Proc] block is the callback
      def set_read_file(&block)
        @read_proc = block
      end

      # Overwrites and re-creates a file with the given text content
      # @param [String] content is the text to write to the file in the path
      # @param [String] path is the path of the file to write
      def write_file(content, path)
        @write_proc.call(content, path) unless @write_proc.nil?
      end

      # Sets the procedure to callback when write_file(content, path) is
      # called.
      # @param [Proc] block is the callback
      def set_write_file(&block)
        @write_proc = block
      end

      # Makes a new directory (if it does not already exist)
      # @param [String] path is the directory path
      def mkdir(path)
        @mkdir_proc.call(path) unless @mkdir_proc.nil?
      end

      # Sets the procedure to callback when mkdir(path) is called
      # @param [Proc] block is the callback
      def set_mkdir(&block)
        @mkdir_proc = block
      end

      # Gets the basename of a given file_path
      def get_basename(file_path)
        @get_basename_proc.call(file_path) unless @get_basename_proc.nil?
      end

      # Sets the procedure to call when get_basename(file_path) is
      # called.
      def set_get_basename(&block)
        @get_basename_proc = block
      end
    end
  end
end