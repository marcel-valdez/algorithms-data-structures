# encoding: utf-8

module Tools
# This class is in charge of extracting the empty exercises from the
# src/**/*.rb files, by stripping them of their implementation.
  class ExerciseExtractor
    INDENT = '  '

    def initialize
      @copy_line = lambda { |line| is_attribute?(line) ? '' : line }
      @ignore_body = lambda { |line| '' }
      @line_processor = nil
      @exit_ignore_regex = nil
    end

    # Strips the body from methods of an exercise
    def strip_content(content)
      lines = ''
      enter_normal_state
      content.each_line { |line|
        line.gsub!("\t", INDENT)
        if is_private_keyword? line
          enter_ignore_state(get_private_end line)
        end

        if is_exit_token? line
          enter_normal_state
        end

        lines += process_line(line)

        if not in_ignore_state? and is_method? line
          enter_ignore_state(get_method_end line)
        end
      }

      lines
    end

    def is_exit_token?(line)
      return false if @exit_ignore_regex.nil?

      not @exit_ignore_regex.match(line).nil?
    end

    def process_line(line)
      @line_processor.call(line)
    end

    def enter_ignore_state(ignore_regex)
      @line_processor= @ignore_body
      @exit_ignore_regex = ignore_regex
    end

    def enter_normal_state
      @line_processor= @copy_line
      @exit_ignore_regex = nil
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
      indent = /(\s+)def\s+[a-zA-Z_0-9]+/.match(line) { |m| m[1] }
      /^#{indent}end(\s*#.*|\s*)$/
    end

    def get_private_end(line, indent = INDENT)
      indent = /(#{indent}*)#{indent}private\s*/.match(line) { |m| m[1] }
      /^#{indent}end\s*$/
    end
  end
end