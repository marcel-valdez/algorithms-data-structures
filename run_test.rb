require 'test-unit'
# run all files in test folder
base_dir = File.expand_path(File.join(File.dirname(__FILE__), '.'))
lib_dir  = [File.join(base_dir, 'src'), File.join(base_dir, 'tools/lib')]
$LOAD_PATH.unshift(lib_dir[0]) unless $LOAD_PATH.include?(lib_dir[0])
$LOAD_PATH.unshift(lib_dir[1]) unless $LOAD_PATH.include?(lib_dir[1])

Test::Unit::AutoRunner.run(true, base_dir)