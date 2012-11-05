require 'test-unit'
require 'simplecov'

SimpleCov.adapters.define("tests") {
  add_filter('/test/')

  add_group('interview exercises', 'src')
  add_group('utilities', 'src/utils')
  add_group('chapter 1', 'src/chapter_1')
  add_group('chapter 2', 'src/chapter_2')
  add_group('chapter 3', 'src/chapter_3')
  add_group('chapter 4', 'src/chapter_4')
  add_group('chapter 5', 'src/chapter_5')
  add_group('chapter 6', 'src/chapter_6')
}

SimpleCov.start "tests"

# run all files in test folder
base_dir = File.expand_path(File.join(File.dirname(__FILE__), "."))
lib_dir  = File.join(base_dir, "src")
test_dir = File.join(base_dir, "test")

$LOAD_PATH.unshift(lib_dir)
exit Test::Unit::AutoRunner.run(true, test_dir)