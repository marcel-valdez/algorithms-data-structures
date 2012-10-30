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

  # Memory complexity: O(N*50) # worst-case if all are unique and start with a different letter each
  # Time complexity: O(N*50) # worst-case if all are unique
  def remove_duplicate_lines(lines)
    #puts "processing lines: #{lines}"
    results = [] # buffer de líneas resultante.
    root = NAryNode.new(50) # crea un árbol n-ario
    lines.each { |line| process_line(line, root, results) } # procesa cada línea.

    results
  end

  def process_line(line, current_node, distinct_lines)
    (0...line.length).each { |i| # recorre todos los caracteres de la línea
      key = key(line[i])
      # nótese que aquí se podría YA determinar si el nodo existe en el árbol, evitando así
      # subsecuentes iteraciones del for, el problema es que si se hace así, entonces ocupas
      # balancear el árbol, por simplicidad, se agrega el nodo sin la bandera 'inserted'.
      current_node.add_child(key) unless current_node.has_child?(key)

      # encuentra el nodo que le corresponde a la llave del caracter en la posición i
      current_node = current_node.children[key]
    }

    unless current_node.inserted? # si su aún no ha sido 'insertado'
      current_node.inserted = true # encender bandera de inserción
      distinct_lines << line # agregar línea al buffer resultante
    end
  end

  def key(char)
    key = (char.downcase.ord - 'a'.ord).abs
    key += 26 if char.ord >= 'A'.ord

    key
  end

  class NAryNode
    attr_accessor :children

    def initialize(n)
      @children = Array.new(n)
      @inserted = false
    end


    def add_child(value)
      @children[value] = NAryNode.new(@children.length)
    end

    def has_child?(value)
      !@children[value].nil?
    end

    def inserted?
      @inserted
    end

    def inserted=(value)
      @inserted=value
    end
  end
end
