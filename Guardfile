# A sample Guardfile
# More info at https://github.com/guard/guard#readme
# Marcel added: :all_after_pass => false, so not all tests execute after a failing test passes
# Marcel added: :cli => '--drb' so that guard uses the command line interface to the Spork server


guard 'rspec', :version => 2, :all_after_pass => false, :cli => '--drb' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
    %W(spec/routing/#{m[1]}_routing_spec.rb spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb spec/acceptance/#{m[1]}_spec.rb)
  end
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch(%r{^app/helpers/(.+)\.rb$}) { |m| "spec"}
  # Marcel added: Watch for a change in the views, and execute the appropriate test file
  watch(%r{^app/views/(.+)/(.+)(\.html\.erb)$}) do |m|
    target = m[1]
    if target.include? "pages"
      "spec/requests/#{target}_spec.rb"
    else
      target[target.length - 1] = ""
      "spec/requests/#{target}_pages_spec.rb"
    end
  end
  # Marcel added: Watch for a change in the locale configurations, and execute acceptance tests
  watch(%r{^config/locales/.+$}) { "spec/requests/" }

  watch('config/routes.rb')                           { :rspec } # "spec/routing" } <-- Marcel edited
  watch('app/controllers/application_controller.rb')  { :rspec } # "spec/controllers" } <-- Marcel edited
  
  # Capybara request specs
  #watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
  
  # Turnip features and steps
  #watch(%r{^spec/acceptance/(.+)\.feature$})
  #watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/routes.rb')
  watch('config/environment.rb')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/factories.rb') #<-- Marcel added so it watches the users factory
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
  # Marcel added: so that it watches the spec/support dir
  watch('spec/') { :rspec }
end
