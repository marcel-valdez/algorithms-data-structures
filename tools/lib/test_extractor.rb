# encoding: utf-8

module Tools
# This class is in charge of extracting the empty exercises from the
# src/**/*.rb files, by stripping them of their implementation.
  class TestExtractor

    def initialize
      @copy_line = lambda { |line| is_attribute?(line) ? '' : line }
      @ignore_body = lambda { |line| '' }
      @line_processor = nil
    end

    # Strips tests by omitting them from a test class
    def strip_content(content)
      result = ''
      multi_type = nil
      content.each_line { |line|
        if /(^\s+def test_)[a-z_0-9]\s*/.match(line) and
            multi_type.nil?
          result += line
          result += /(^\s+)def\stest_.*/.match(line) { |m|
            "#{m[1]}  omit('Yet to see the light.')\n"
          }
        else
          result += line
        end

        multi_type = is_multiline?(line, multi_type)
      }

      result
    end

    # Determines whether a line is a multiline due to a
    # double quote or a single quote.
    # If the line is multiline string due to a pending single quote
    # it returns :single
    # If the line is multiline string due to a pending double quote
    # it returns :double
    # Otherwise it returns nil
    # @return [Symbol] that determines the kind of multiline
    # @param [Symbol] previous multiline character, it can be any of:
    #                 :single, :double or nil
    def is_multiline?(line, previous = nil)
      single = 0 + ((:single == previous) ? 1 : 0)
      double = 0 + ((:double == previous) ? 1 : 0)

      (0...line.length).each { |i|
        if single%2 == 0
          double += 1 if line[i].eql? '"'
        end

        if double%2 == 0
          single += 1 if line[i].eql? "'"
        end

        if line[i].eql? '#'
          if single%2 == 0 and double%2 == 0
            break
          end
        end
      }

      if double%2 == 1
        return :double
      elsif single%2 == 1
        return :single
      else
        return nil
      end
    end
  end
end