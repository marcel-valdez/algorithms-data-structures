class Chapter1Exercises
  attr :exercise_1121_trace


  # To change this template use File | Settings | File Templates.
  def exercise_113 numbers
    integers = numbers.split(' ').each { |number| number.to_i }

    result = true
    integers.each { |integer| result = result && integer == integers[0] }

    result
  end

  def exercise_115 numbers
    numbers.reduce do |number|
      number > 0 and number < 1
    end
  end

  def exercise_116
    result = ""
    f = 0
    g = 1
    for i in 0..15
      result += "#{f}, "
      f += g
      g = f - g
    end

    result
  end

  def exercise_117
    t = 9.0
    while (t - 9.0/t).abs > 0.0001
      t = (9.0/t + t) / 2.0
    end

    result = "a) Square root: #{t}\n"

    sum = 0
    for i in 1...6
      for j in 0...i
        sum += 1
      end
    end

    result += "b) Sumatoria de secuencias del 1 al 5: #{sum}\n"

    sum = 0
    i = 1
    # mientras la potencia de 2 sea menor que 1000
    while i < 1000
      # agrega 1000 a la sumatoria
      for j in 1..1000
        sum+=1
      end

      i *= 2
    end

    # resultado: 1000 * log2 de 1000
    result += "c) Misterios #{sum} debe ser igual a #{1000*Math.log2(1000).ceil}"

    result
  end

  # returns the binary representation of number into a string
  def exercise_119 number
    # if the number is 0, set the result to '0'
    result = number == 0 ? "0" : ""
    # until we're done looping the number by dividing it by two
    while number > 0
      # append to the result its least significant bit
      result =(number & 1).to_s + result
      # roll bits to the right so we can print the next bit
      number >>= 1
    end

    result
  end

  # Write a code fragment that prints the contents of a two-dimensional boolean array,
  # using * to represent true and a space to represent false. Include row and column numbers.
  def exercise_1111 bool_values

    # Poner los headers de cada columna
    result = " #{(1..bool_values[0].length).inject("") { |str, i| str + i.to_s }}\n"

    for i in 0..(bool_values.length - 1)
      # Poner el numero de renglon
      result += "#{i + 1}"
      for j in 0..(bool_values[i].length - 1)
        # Poner el valor booleano
        result += bool_values[i][j] ? '*' : ' '
      end
      # Line feed por cada renglon
      result += "\n"
    end

    result
  end

  #Write a code fragment to print the transposition (rows and columns changed) of
  #a two-dimensional array with M rows and N columns.
  def exercise_1113 matrix
    m = matrix.length
    n = matrix[0].length

    result = Array.new(n) { Array.new(m) { 0 } }
    for i in 0..m-1
      for j in 0..n-1
        result[j][i] = matrix[i][j]
      end
    end

    result
  end

  def exercise_1114 number
    result = 0
    while number > 1
      result+=1
      number >>= 1
    end

    result
  end

  def exercise_1115 numbers = [], size = 0
    result = Array.new(size) { 0 }
    numbers.each { |number| result[number] += 1 unless number >= size }

    result
  end

  def exercise_1119 n
    result = Array.new(n + 1) { 0 }
    first = 0
    second = 1
    for i in 0...n
      result[i] = first
      result[i + 1] = second
      second = second + first
      first = result[i + 1]
    end

    result
  end


  BASE_E = 2.71828182845904523536028747135266249775724709369995

  def exercise_1120 number
    result = 0
    sum_result = 0
    while number > 1
      result += 1
      sum_result += result
      number = number / BASE_E
    end

    number < BASE_E ? nil : result
  end

  def exercise_1121 key = 0, arr = []
    @exercise_1121_trace = ""
    rank(key, arr, 0, arr.length - 1, 0)
    @exercise_1121_trace
  end

  def rank key, arr, lo, hi, depth
    return - 1 if lo > hi
    mid = lo + (hi - lo) / 2
    @exercise_1121_trace += ("\t"*depth) + "lo: #{lo}, hi: #{hi}\n"
    return rank(key, arr, lo, mid - 1, depth+1) if key < arr[mid]
    return rank(key, arr, mid + 1, hi, depth+1) if key > arr[mid]

    mid
  end
end