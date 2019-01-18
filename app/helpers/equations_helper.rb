module EquationsHelper
  def equation_components(str)
    str.enum_for(:scan, /\W+|\d+/).map { Regexp.last_match.to_s }
  end

  def check(op, arr, func)
    arr.any? { |i| i == op} ? func(arr) : arr
  end

  def mult_loop(arr)
    x = -1
    arr.each do |i|
      if i == '*'
        arr[x] = arr[x].to_i * arr[x + 2].to_i
        arr[x + 1..x + 2] = []
      end
    x += 1
    end
  end

  def multiply(str)
    array = equation_components(str)
    mult_loop(array)
    check('*', array, mult_loop(array))
  end

  def div_loop(arr)
    x = -1
    arr.each do |i|
      if i == '/'
        arr[x] = (arr[x].to_i / arr[x + 2].to_f).round(2)
        arr[x + 1..x + 2] = []
      end
    x += 1
    end
  end

  def divide(str)
    array = multiply(str)
    div_loop(array)
    check('/', array, div_loop(array))
  end

  def add_loop(arr)
    x = -1
    arr.each do |i|
      if i == '+'
        arr[x] = arr[x].to_f + arr[x + 2].to_f
        arr[x + 1..x + 2] = []
      end
    x += 1
    end
  end

  def add(str)
    array = divide(str)
    add_loop(array)
    check('+', array, add_loop(array))
  end

  def sub_loop(arr)
    x = -1
    arr.each do |i|
      if i == '-'
        arr[x] = arr[x].to_f - arr[x + 2].to_f
        arr[x + 1..x + 2] = []
      end
    x += 1
    end
  end

  def subtract(str)
    array = add(str)
    sub_loop(array)
    check('-', array, sub_loop(array))
  end

  def final_tally(str)
    array = subtract(str)
    result = array[0]
    if result.is_a? Numeric
      result == result.round ? result.round : result
    else
      "Please enter a valid formula. No spaces are allowed."
    end
  end
end
