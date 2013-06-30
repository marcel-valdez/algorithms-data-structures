# encoding: utf-8
# This file fixes the guard-test gem on Cloud9 IDE.
class ::Guard::Test::Runner
    def run(paths, opts = {})
        return true if paths.empty?
        ::Guard::UI.info(opts[:message] || "Running: #{paths.join(' ')}", :reset => true)
        commands = test_unit_command(paths)
        if ENV.include? "C9_PROJECT"
            bundle_cmd = commands.split.take_while { |cmd| cmd != "ruby" }
            if bundle_cmd.join(' ') == 'bundle exec'
                ruby_cmd = commands.split.drop_while { |cmd| cmd != "ruby" }
                commands = "#{bundle_cmd.join ' '} '#{ruby_cmd.join ' '}'"
            end
        end

        system(commands)
    end
end