module Tools
  # FileSys is a wrapper over the file system
  class FileSys

    # Determines whether the path exists.
    # @param [String] path is the file path
    # @return [Boolean] true if it exists, false otherwise
    def exists?(path)
      File.exist? path
    end

    # Determines whether the specified path is a directory
    # @return [String] the path to a file
    def is_dir?(path)
      File.directory? path
    end

    # Gets the filename and extension of a file in a path.
    # @param [String] file_path is the file path to get its basename.
    # @return [String] the base name of the file (filename + extension)
    def get_basename(file_path)
      File.basename file_path
    end

    # Determines whether a file is readable.
    # If it does not exist or is locked exclusively, it returns false.
    # @param [String] path
    # @return [Boolean] true if it can be read, false otherwise.
    def is_readable?(path)
      File.exists? path and File.readable? path
    end

    # Reads a file and returns its text contents
    # @return [String] reads the text contents of a file
    def read_file(path)
      raise "File #{path} is not readable." unless is_readable?(path)

      File.read path
    end

    # Makes a new directory (if it does not already exist)
    # @param [String] path is the directory path
    def mkdir(path)
      Dir.mkdir path unless exists? path
    end

    # Gets the subdirectories in a given directory
    # @return [Array] the subdirectories in the directory path
    def get_subdirs(directory)
      Dir.entries(directory).select { |entry|
        entry != '.' and entry != '..' and is_dir?("#{directory}/#{entry}")
      }
    end

    # Gets non-directory files inside a directory
    # @return [Array] the non-directory files inside the given directory path
    def get_files(directory)
      Dir.entries(directory).select { |entry| not is_dir?("#{directory}/#{entry}") }
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
  end
end