# encoding: utf-8

module Tools
# This class is in charge of extracting the empty exercises from the
# src/**/*.rb files, by stripping them of their implementation.
  class ExerciseExtractor

    def initialize
      @copy_line = lambda { |line| line }
      @ignore_body = lambda { |line| '' }
    end

    # Strips the body from methods of an exercise
    def strip_methods(content)
      lines = ''
      method_end = ''
      in_method_body = false
      line_processor = @copy_line

      content.each_line { |line|

        if in_method_body and line == method_end
          line_processor = @copy_line
          in_method_body = false
        end

        lines += line_processor.call(line)

        if is_method? line
          method_end = get_method_end line
          line_processor = @ignore_body
          in_method_body = true
        end
      }

      lines
    end

    def is_method?(line)
      (line =~ /(\s+)def\s+[a-zA-Z_0-9]+/) == 0
    end

    def get_method_end(line)
      /(\s+)def\s+[a-zA-Z_0-9]+/.match(line) { |m| m[1] + "end\n" }
    end
  end
end