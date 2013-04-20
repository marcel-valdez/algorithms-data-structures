require_relative 'file_sys'

module Tools
  # Class FolderExtractor should read all ruby files in a folder hierarchy
  # and extract all exercise methods without any implementation, into
  # another folder hierarchy.
  class FolderExtractor

    # @param [Object] exercise_extractor must respond to strip_methods
    def initialize(exercise_extractor = nil, file_sys = nil)
      @ex_extractor = exercise_extractor
      @file_sys = file_sys

      if exercise_extractor.nil?
        @ex_extractor = ExerciseExtractor.new
      end

      if file_sys.nil?
        @file_sys = FileSys.new
      end
    end

    # This method extracts all exercise files from a given folder hierarchy,
    # considering only .rb files.
    # TODO: Write test.
    # @param [String] from is the directory from which to extract exercises.
    # @param [String] to is the directory into which extract exercises
    def extract(from, to)
      raise "#{from} does not exist." unless @file_sys.exists? from
      raise "#{to} does not exist." unless @file_sys.exists? to

      raise "#{from} is not a directory." unless @file_sys.is_dir? from
      raise "#{to} is not a directory." unless @file_sys.is_dir? to

      dirs = @file_sys.get_subdirs from
      files = @file_sys.get_files from

      @file_sys.mkdir to

      files.select { |file| file.end_with? '.rb' }.
          each { |file| strip_file("#{from}/#{file}", to) }

      dirs.each { |dir| extract("#{from}/#{dir}", "#{to}/#{dir}") }
    end

    # Strips the file from its implementation, and copies the stripped
    # content to a new file in dst_dir/file_path.
    # @param [String] file_path
    # @param [String] dst_dir
    def strip_file(file_path, dst_dir)
      content = @file_sys.read_file file_path
      stripped_content = @ex_extractor.strip_methods content
      @file_sys.write_file(stripped_content,
                           "#{dst_dir}/#{@file_sys.get_basename(file_path)}")
    end
  end
end