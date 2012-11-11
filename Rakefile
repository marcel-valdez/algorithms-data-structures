require 'simplecov'
require 'rake/testtask'
require 'flay_task'
require 'cane/rake_task'

task :default => [:test, :coverage, :check_style] do
end

desc "Run tests in the project"
Rake::TestTask.new(:test) do |test|
  test.libs << 'src' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end


desc "Run tests with code coverage."
task :coverage do
  SimpleCov.start do
    add_filter('/test/')
    add_filter('/src/chapter_5/section_1/lds_exercises.rb')

    add_group('interview exercises', 'src/interview_exercises.rb')
    add_group('utilities', 'src/utils')
    add_group('chapter 1', 'src/chapter_1')
    add_group('chapter 2', 'src/chapter_2')
    add_group('chapter 3', 'src/chapter_3')
    add_group('chapter 4', 'src/chapter_4')
    add_group('chapter 5', 'src/chapter_5')
    add_group('chapter 6', 'src/chapter_6')

    SimpleCov.command_name "Unit Tests"
    SimpleCov.minimum_coverage(90)
    SimpleCov.refuse_coverage_drop
  end

  base_dir = File.expand_path(File.join(File.dirname(__FILE__), "."))
  lib_dir = File.join(base_dir, "src")
  test_dir = File.join(base_dir, "test")
  require_dir_files(lib_dir)
  require_dir_files(test_dir)

  #$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
  #$LOAD_PATH.unshift(test_dir) unless $LOAD_PATH.include?(test_dir)
  #Rake::Task['test'].execute
end

desc "Check coding style with cane"
Cane::RakeTask.new(:style) do |cane|
  cane.abc_glob = '{test}/**/*.rb'
  cane.abc_max = 15
  cane.style_measure = 100
  cane.doc_glob = 'test/**/*.rb'
  cane.style_glob = '{src,test}/**/*.rb'
  cane.no_style = false
  # TODO: Reduce cane style violations
  cane.max_violations = 159
end

desc "Use flay to check code similarity"
FlayTask.new(:flay) do |flay|
  flay.dirs = %w(src test)
  flay.verbose = true
  # TODO: Reduce flay values
  # TODO: Reduce flay found IDENTICAL code
  flay.threshold = 1030
end

desc "Check for good style and code similarity"
# Had to make it depend on coverage so it is not ran before simplecov
task :check_style => [:flay, :style] do
end

def require_dir_files(dir_path)
  Dir["#{dir_path}/**/*.rb"].each { |file|
    require file unless do_not_cover? file }
end

def do_not_cover?(file)
  ignored = []# ["lsd_exercises"]

  ignored.each {|name| return true if file.include? name}
  false
end
