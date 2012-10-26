#encoding: utf-8

module Chapter2
  module Section1
    class ShellSortExercises
      def shell_sort_increment_e2111(size)
        result = [1]
        h = 1
        while h < size/3
          h = (3*h)+1
          result << h
        end

        # puts "Sequence #{result.inspect} for size: #{size}"
        result
      end
    end
  end
end
