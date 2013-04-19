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

      def setup
        @target = FolderExtractor.new
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

      def make_file_sys(dir, fail_exist = false, fail_dir = false)
        file_sys = Object.new
        if fail_exist
          file_sys.send(:instance_eval,
                        "def exists?(x); return !x.eql?('#{dir}'); end")
        else
          file_sys.send(:instance_eval,
                        'def exists?(x); true; end')
        end

        if fail_dir
          file_sys.send(:instance_eval,
                        "def is_dir?(x); return !x.eql?('#{dir}'); end")
        else
          file_sys.send(:instance_eval,
                        'def is_dir?(x); true; end')
        end

        file_sys
      end
    end

    # TODO: Test the extract method
    # NOTE: I created the implementation first because it was
    # somewhat complicated and needed to code it first.

    # This is a mock class for the FileSys class, in order to
    # isolate from the filesystem.
    class MockFileSys
      def dir_struct=(structure)
        @structure=structure
      end
      # Determines whether the path exists.
      # @param [String] path is the file path
      # @return [Boolean] true if it exists, false otherwise
      def exists?(path)
        @structure.any? path
      end

      # Gets the subdirectories in a given directory
      # @return [Array] the subdirectories in the directory path
      def get_subdirs(directory)
        path = directory.split('/')
        structure = @structure
        path.each {|token|
          if structure.include? token
            structure = structure[token]
          else
            structure = nil
          end
        }

        structure
      end

      # Gets non-directory files inside a directory
      # @return [Array] the non-directory files inside the given directory path
      def get_files(directory)

      end

      # Determines whether the specified path is a directory
      # @return [String] the path to a file
      def is_dir?(path)

      end

      # Reads a file and returns its text contents
      # @return [String] reads the text contents of a file
      def read_file(path)
      end

      # Overwrites and re-creates a file with the given text content
      # @param [String] content is the text to write to the file in the path
      # @param [String] path is the path of the file to write
      def write_file(content, path)
      end

      # Makes a new directory (if it does not already exist)
      # @param [String] path is the directory path
      def mkdir(path)
      end
    end
  end
end