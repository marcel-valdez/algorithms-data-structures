class InterviewExercises
  def fast_reverse (input)
    left_edge = 0
    right_edge = input.length - 1
    until left_edge >= right_edge
      initial_left = input[left_edge]
      input[left_edge] = input[right_edge]
      input[right_edge] = initial_left

      left_edge += 1
      right_edge -= 1
    end
    
    input
  end
end