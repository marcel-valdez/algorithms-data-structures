# encoding: utf-8

module Tools
# This class is in charge of extracting the empty exercises from the
# src/**/*.rb files, by stripping them of their implementation.
  class ExerciseExtractor

    def initialize
      @copy_line = lambda { |line| is_attribute?(line) ? '' : line }
      @ignore_body = lambda { |line| '' }
      @line_processor = nil
    end

    # Strips the body from methods of an exercise
    def strip_content(content)
      lines = ''
      exit_ignore_token = nil
      enter_normal_state

      content.each_line { |line|
        unless exit_ignore_token.nil?
          puts "<#{line}> ? <#{exit_ignore_token}> = #{line.eql? exit_ignore_token}"
        end

        if is_private_keyword? line
          enter_ignore_state
          exit_ignore_token = get_private_end line
        end

        if line.eql? exit_ignore_token
          enter_normal_state
          exit_ignore_token = nil
        end

        lines += process_line(line)

        if not in_ignore_state? and is_method? line
          enter_ignore_state
          exit_ignore_token = get_method_end line
        end
      }

      lines
    end

    def process_line(line)
      @line_processor.call(line)
    end

    def enter_ignore_state
      @line_processor= @ignore_body
    end

    def enter_normal_state
      @line_processor= @copy_line
    end

    def in_ignore_state?
      @line_processor.eql? @ignore_body
    end

    # Determines if the line code is an attribute line
    # attr_reader :reader (true)
    # attr_writer :writer, :other (true)
    # attr_accessor :accessor (true)
    # @return [Boolean]
    # @param [String] line to check
    def is_attribute?(line)
      (line =~ /(\s+)attr_(writer|reader|accessor)\s+:[a-zA-Z_0-9]+/) == 0
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
      /(#{indent}+)#{indent}private\s+/.match(line) { |m| m[1] + 'end' }
    end
  end
end