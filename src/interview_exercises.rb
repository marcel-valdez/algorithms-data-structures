# encoding: utf-8

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

  # Memory complexity: O(N) # worst-case if all are unique and start with a different letter each
  # Time complexity: O(N*50) # worst-case if all are unique
  def remove_duplicate_lines(lines)
    results = [] # resulting buffer.
    root = NAryNode.new("", 50) # root node of an n-ary tree
    lines.each { |line| results << line if distinct_line?(line, root) } # process each line separately

    results
  end

  # Worst-case time complexity for a single search: O(n log n)
  # this happens when the entire tree has to be traversed before
  # traversing to each node's parent
  # Average-time complexity for a single search: O(log n)
  def find_path(src, dst, invoker = nil)
    return "n"  if src.nil? # n if did not find a path to dst
    return src.value.to_s if src.value == dst.value # src if reached dst
    # start off without a valid path
    path = "n"
    if dst.value < src.value # if dst is to the left
      # try to find dst in left sub-tree, unless left child is the invoker
      path = find_path(src.left, dst, src)  unless src.left == invoker
    elsif dst.value > src.value # if dst is to the right
      # try to find dst in right sub-tree, unless right child is the invoker
      path = find_path(src.right, dst, src)  unless src.right == invoker
    end

    if path.end_with? "n" # if dst wasn't found in children
      # look for path in parent, unless parent is the invoker
      path = find_path(src.parent, dst, src)  unless src.parent == invoker
    end
    # return path from src to end
    "#{src.value},#{path}"
  end

  # TODO: Write tests for this.
  # Write a function that receives 2 Binary Tree nodes and a root, and
  # finds the least common ancestor, if there is one, if the nodes are not
  # connected, then return nil.

  def distinct_line?(line, current_node)
    previous_node = current_node
    (0...line.length).each { |i| # transverse all characters
      key = key(line[i])

      if current_node.has_child?(key) # child node corresponding to the key
        previous_node = current_node
        current_node = current_node.children[key]
      else # At a leaf node
        return distinct_node?(current_node, previous_node, i, line)
      end
    }

    distinct_node?(current_node, previous_node, line.length - 1, line)
  end

  def distinct_node?(current_node, previous_node, tree_depth, line)
    key = key(line[tree_depth])
    comparison = line <=> current_node.value
    if comparison > 0 # if the new value should be stored as a child of the node
      current_node.add(key, line)
    elsif comparison < 0 # if the new value should be stored as the parent of the current node
      previous_node.insert_at(key(line[tree_depth- 1]), line, key)
    end

    comparison != 0
  end

  def key(char)
    key = (char.downcase.ord - 'a'.ord).abs
    key += 26 if char.ord >= 'A'.ord

    key
  end

  class NAryNode
    attr_accessor :children, :value

    def initialize(value, n)
      @children = Array.new(n)
      @inserted = false
      @value = value
    end

    # @param [Object] key The key at which to insert a new node
    # @param [Object] value The value of the node to be inserted at the key
    # @param [Object] replace_key They key for the old node as a child of the new node.
    def insert_at(key, value, replace_key)
      new_node = NAryNode.new(value, @children.length)
      old_node = @children[key]
      new_node.children[replace_key] = old_node
      @children[key] = new_node
    end

    def add(key, value)
      new_node = NAryNode.new(value, @children.length)
      @children[key] = new_node
    end

    # @param [Object] key of a child
    # @return [Boolean] true if this node has a child at the given key index
    def has_child?(key)
      !@children[key].nil?
    end
  end

end
