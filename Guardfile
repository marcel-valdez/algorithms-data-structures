# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :test do
  # Watch all exercise files and run their respective test
  # watch(src/[chapter]/[exercise]) { run test/[chapter]/[exercise]_test.rb}
  watch(%r{^src/(.+)/(.+)\.rb$})     { |m| "test/#{m[1]}/#{m[2]}_test.rb" }

  # Watch all tests
  # watch(test/[chapter]/*_test.rb)
  watch(%r{^test/(.+)/.+_test\.rb$})

  #Watch the test helper, and if modified, run all tests
  watch('test/test_helper.rb')  { "test" }

  # Watch the utils directory, and if modified run all tests
  watch(%r{^src/utils/(.+)\.rb$})     { "test" }

end