source 'http://rubygems.org'

group :development do
  gem 'spork'
  gem 'guard-spork'
  gem 'rb-readline'
  gem 'guard', '1.5.1'
  gem 'guard-test'
  gem 'listen'
  gem 'rb-inotify', '~> 0.8.8'
  gem 'libnotify' unless ENV['OS'] == 'Windows_NT'
  gem 'wdm', '~> 0.0.3' if ENV['OS'] == 'Windows_NT'
end

gem 'test-unit', :group => [:development, :test]
gem 'flay', :group => [:development, :test]
gem 'rake', :group => :test
gem 'cane', :group => :test
gem 'simplecov', :group => :test
