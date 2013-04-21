require_relative 'tools/lib/file_sys'
require_relative 'tools/lib/exercise_extractor'
require_relative 'tools/lib/test_extractor'
require_relative 'tools/lib/folder_extractor'

include Tools

if ARGV.length < 2
  puts 'This script creates the user project based on the exercises
and tests at a source/directory/src and source/directory/test.

This script needs two arguments:
ruby extract_user_project.rb source/directory destination/directory'
  return 1
end

src_dir = ARGV[0]
dst_dir = ARGV[1]

file_sys = FileSys.new

unless file_sys.exists? src_dir
  puts "The path: #{src_dir} does not exist."
  exit(false)
end

unless file_sys.is_dir? src_dir
  puts "The path: #{src_dir} is not a directory."
  exit(false)
end

unless file_sys.exists? File.dirname(dst_dir)
  puts "The path: #{File.dirname(dst_dir)} must exist."
  exit(false)
end

test_extractor = FolderExtractor.new(TestExtractor.new, file_sys)
src_extractor = FolderExtractor.new(ExerciseExtractor.new, file_sys)

file_sys.mkdir dst_dir

src_extractor.extract "#{src_dir}/src", "#{dst_dir}/src"
test_extractor.extract "#{src_dir}/test", "#{dst_dir}/test"

file_sys.write_file(File.read("#{src_dir}/Guardfile"), "#{dst_dir}/Guardfile")
file_sys.write_file(File.read("#{src_dir}/Gemfile"),
                    "#{dst_dir}/Gemfile")
file_sys.write_file(File.read("#{src_dir}/run_guard.rb"),
                    "#{dst_dir}/run_guard.rb")
file_sys.write_file(File.read("#{src_dir}/run_test.rb"),
                    "#{dst_dir}/run_test.rb")


exit(true)