# encoding: utf-8

require_relative '../../test_helper'
require_relative '../../../src/chapter_1/section_3/bag_exercises'

module Chapter1
  module Section3
    class BagExercisesTest < TestHelper

      # Called before every test method runs. Can be used
      # to set up fixture information.
      def initialize(*args)
        super(*args)
        @target = BagExercises.new
      end

      # Exercise 1.3.34
      # Write a method random_bag_e1334 that returns the items
      # of a bag in a random order
      def test_e1334_random_bag
        failure_count = 0
        previous_random = (0...100).to_a
        repetition_error = nil
        (0...100).each {
          begin
            values = (0...100).to_a
            verify_method  :e1334_random_bag,
                          :with => [{
                                        param: values,
                                        predicate: Proc.new { |result|
                                          is_random = check_random_result(previous_random, result)
                                          previous_random = result
                                          is_random
                                        }
                                    }]
          rescue Test::Unit::AssertionFailedError => e
            repetition_error = e
            failure_count += 1
          end
        }

        if failure_count > 5
          msg = "More than 5 out of 100 permutations did not shuffle\n"
          msg += "there's an extremely high chance that your shuffle method\n"
          msg += "isn't truly random."

          raise Test::Unit::AssertionFailedError.new msg, repetition_error
        end
      end

      # Called for check result of test_e1334_random_bag
      def check_random_result (values, result)
        #values.each { |item| puts(item)}
        #result.each { |item| puts(item)}
        #puts result.inspect

        if values.length != result.length
          puts 'The number of result values is different than the number of param values'
          return false
        end

        for i in 0 .. result.length-1
          if result[i].nil?
            puts 'The number of result values is different than the number of param values'
            return false
          end
        end

        for i in 0...result.length
          if values[i] != result[i]
            return true
          end
        end

        puts 'The result and values are in exactly the same order'

        puts "Offending result: #{result.inspect}"
        false
      end
    end
  end
end