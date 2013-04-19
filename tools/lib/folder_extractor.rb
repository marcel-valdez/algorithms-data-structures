module Tools
  # Class FolderExtractor should read all ruby files in a folder hierarchy
  # and extract all exercise methods without any implementation, into
  # another folder hierarchy.
  class FolderExtractor

    # @param [Object] exercise_extractor must respond to strip_methods
    def initialize(exercise_extractor = nil, filesys = nil)
      @ex_extractor = exercise_extractor
      @filesys = filesys

      if exercise_extractor.nil?
        @ex_extractor = ExerciseExtractor.new
      end

      if filesys.nil?
        @filesys = FileSys.new
      end
    end

    # This method extracts all exercise files from a given folder hierarchy,
    # considering only .rb files.
    # TODO: Write test.
    # @param [String] from is the directory from which to extract exercises.
    # @param [String] to is the directory into which extract exercises
    def extract(from, to)
      raise "#{from} does not exist." unless @filesys.exists? from
      raise "#{to} does not exist." unless @filesys.exists? to

      raise "#{from} is not a directory." unless @filesys.is_dir? from
      raise "#{to} is not a directory." unless @filesys.is_dir? to

      dirs = @filesys.get_subdirs from
      files = @filesys.get_files from

      @filesys.mkdir to

      files.select { |file| file.end_with? '.rb' }.
          each { |file| strip_file(file, to) }

      dirs.each { |dir| extract("#{from}/#{dir}", "#{to}/#{dir}") }
    end

    # Strips the file from its implementation, and copies the stripped
    # content to a new file in dst_dir/file_path.
    # TODO: Write test.
    # @param [String] file_path
    # @param [String] dst_dir
    def strip_file(file_path, dst_dir)
      content = @filesys.read_file file_path
      stripped_content = @ex_extractor.strip_methods content
      @filesys.write_file stripped_content, "#{dst_dir}/#{file_path}"
    end
  end

  # FileSys is a wrapper over the file system
  # TODO: Needs tests for:
  # - mkdir
  # - get_subdirs
  # - get_files
  # - read_file
  # - write_file
  class FileSys

    # Determines whether the path exists.
    # @param [String] path is the file path
    # @return [Boolean] true if it exists, false otherwise
    def exists?(path)
      File.exist? path
    end

    # Gets the subdirectories in a given directory
    # @return [Array] the subdirectories in the directory path
    def get_subdirs(directory)
      Dir.entries(directory).select { |entry| is_dir? entry }
    end

    # Gets non-directory files inside a directory
    # @return [Array] the non-directory files inside the given directory path
    def get_files(directory)
      Dir.entries(directory).select { |entry| not is_dir? entry }
    end

    # Determines whether the specified path is a directory
    # @return [String] the path to a file
    def is_dir?(path)
      File.directory? path
    end

    # Reads a file and returns its text contents
    # @return [String] reads the text contents of a file
    def read_file(path)
      raise "File #{path} is not readable." unless is_readable?(path)

      File.read path
    end

    # Determines whether a file is readable.
    # If it does not exist or is locked exclusively, it returns false.
    # @param [String] path
    # @return [Boolean] true if it can be read, false otherwise.
    def is_readable?(path)
      File.exists? path and File.readable? path
    end

    # Overwrites and re-creates a file with the given text content
    # @param [String] content is the text to write to the file in the path
    # @param [String] path is the path of the file to write
    def write_file(content, path)
      File.delete path if File.exists? path

      file = File.new path, 'w+'
      file.write content

      file.close
    end

    # Makes a new directory (if it does not already exist)
    # @param [String] path is the directory path
    def mkdir(path)
      Dir.mkdir path unless exists? path
    end
  end
end