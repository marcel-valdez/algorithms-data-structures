require 'test-unit'
# run all files in test folder
base_dir = File.expand_path(File.join(File.dirname(__FILE__), "."))
lib_dir  = File.join(base_dir, "src")
test_dir = File.join(base_dir, "test")
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)


Test::Unit::AutoRunner.run(true, test_dir)