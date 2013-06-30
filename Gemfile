source 'http://rubygems.org'

group :development do
  gem 'rb-readline'
  gem 'guard'
  gem 'guard-test'
  gem 'listen'
  gem 'rb-inotify', '~> 0.9'
  gem 'libnotify' unless ENV['OS'] == 'Windows_NT'
  gem 'wdm', '~> 0.0.3' if ENV['OS'] == 'Windows_NT'
end

group :test do 
  gem 'rake'
  gem 'cane'
  gem 'simplecov'
end

gem 'test-unit', :group => [:development, :test]
gem 'flay', :group => [:development, :test]