require_relative "../../test_helper"
require_relative "../../../src/chapter_1/section_3/bag_exercises"

module Chapter1
  module Section3
    class Bag_exercises_test < TestHelper

      # Called before every test method runs. Can be used
      # to set up fixture information.
      def initialize(*args)
        super(*args)
        @target = BagExercises.new
      end

      #Exercise 1.3.34
      # Write a method random_bag_e1334 that returns the items 
      # of a bag in a random order
      def test_random_bag_e1334
        values = [5, 6, 8, 12, 3, 4]
        verify_method :random_bag_e1334,
                      :with => [{
                        param: values, 
                        predicate: Proc.new { |result| 
                          check_random_result(values.reverse, result)
                          }
                        }]
      end

      # Called for check result of test_random_bag_e1334
      def check_random_result (values, result)
        #values.each { |item| puts(item)}
        #result.each { |item| puts(item)}
        #puts result.inspect

        if values.length != result.length
          puts "The number of result values is different than the number of param values"
          return false
        end

        for i in 0 .. result.length-1
          if result[i].nil?
            puts "The number of result values is different than the number of param values"
            return false
          end
        end

        for i in 0 .. result.length-1
          if values[i] != result[i]
            return true
          end
        end
        
        puts "The result is not shuffled"
        return false
      end
    end
  end
end