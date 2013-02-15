#encoding: utf-8

module Chapter2
  module Section1
    class ShellSortExercises
      def e2111_shell_sort_increment(size)
        result = [1]
        h = 1
        while h < size/3
          h = (3*h)+1
          result << h
        end

        result
      end
    end
  end
end
