# encoding: utf-8

require_relative '../../test/test_helper'
require_relative '../lib/file_sys'

module Tools
  module Tests
    # Contains the unit tests for the FolderExtractor class
    class FileSysTest < TestHelper
      # initializes this test instance
      def initialize (arg)
        super(arg)
        @curr_dir = File.dirname(__FILE__)
      end

      # Tests that the extractor fails when sent a file path
      # that does not exist in the 'from' argument.
      test 'it should not get current and upper dir' do
        # arrange
        target = FileSys.new
        # act
        dirs = target.get_subdirs "#{@curr_dir}/data"
        # assert
        assert_not_nil dirs
        assert_not_include dirs, '.'
        assert_not_include dirs, '..'
        assert_include dirs, 'inner'
      end

      test 'it should get files, not directories' do
        # arrange
        target = FileSys.new
        # act
        files = target.get_files "#{@curr_dir}/data"
        # assert
        assert_not_nil files
        assert_not_include files, '.'
        assert_not_include files, '..'
        assert_equal files.length, 3
        assert_include files, 'my_class.rb'
        assert_include files, 'my_other_class.rb'
        assert_include files, 'some_not.rb.txt'
      end

      test 'write file should overwrite and read file contents' do
        # arrange
        file_contents = nil
        expected_contents = 'yyy'
        file_name = "#{@curr_dir}/test_file"
        begin
          file = File.new file_name, File::CREAT
          file.close
          File.write file_name, 'xxx'
          target = FileSys.new
          # assume
          assert_equal File.read(file_name), 'xxx'

          # act
          target.write_file expected_contents, file_name
          file_contents = target.read_file(file_name)
        ensure
          # clean-up
          File.delete file_name if File.exists? file_name
        end
        # assert
        assert_equal file_contents, expected_contents
      end
    end
  end
end