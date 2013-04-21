
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
    return @get_subdirs_proc.call(directory) unless @get_subdirs_proc.nil?
    []
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
    return @get_files_proc.call(directory) unless @get_files_proc.nil?
    []
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