# encoding: utf-8

module Tools
# This class is in charge of extracting the empty exercises from the
# src/**/*.rb files, by stripping them of their implementation.
  class ExerciseExtractor

    def initialize
      @copy_line = lambda { |line| line }
      @ignore_body = lambda { |line| '' }
      @line_processor = nil
    end

    # Strips the body from methods of an exercise
    def strip_methods(content)
      lines = ''
      expected_end = nil
      @line_processor= @copy_line

      content.each_line { |line|
        puts line
        if is_private_keyword? line
          @line_processor = @ignore_body
          expected_end = get_private_end line
        end

        if found_state_end?(expected_end, line)
          set_normal_state()
          expected_end = nil
        end

        lines += process_line(line)

        if not in_ignored_state? and is_method? line
          expected_end = get_method_end line
          set_ignore_state()
        end
      }

      lines
    end

    def process_line(line)
      @line_processor.call(line)
    end

    def set_ignore_state
      @line_processor= @ignore_body
    end

    def set_normal_state
      @line_processor= @copy_line
    end

    def in_ignored_state?
      @line_processor.eql? @ignore_body
    end

    def found_state_end?(expected_end, line)
      line == expected_end
    end

    def is_method?(line)
      (line =~ /(\s+)def\s+[a-zA-Z_0-9]+/) == 0
    end

    def is_private_keyword?(line)
      (line =~ /\s*private\s*/) == 0
    end

    def get_method_end(line)
      /(\s+)def\s+[a-zA-Z_0-9]+/.match(line) { |m| m[1] + "end\n" }
    end

    def get_private_end(line, indent = '  ')
      /(#{indent}+)#{indent}private\s+/.match(line) { |m| m[1] + "end" }
    end
  end
end