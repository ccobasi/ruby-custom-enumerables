# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Style/For
module Enumerable
  def my_each
    array = self

    return to_enum unless block_given?

    for i in array do
      yield i
    end

    array
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    for element in self
      yield element, i
      i += 1
    end

    self
  end

  def my_select
    array = self

    return to_enum unless block_given?

    new_array = []

    for number in array
      was_selected = yield number
      new_array.push number if was_selected
    end

    new_array
  end

  def my_all?(pattern = nil)
    if block_given?
      for number in self
        predicate = yield number
        return false unless predicate
      end
    elsif pattern.is_a? Class
      for number in self
        return false unless number.is_a? pattern
      end
    elsif !pattern.nil?
      for number in self
        predicate = pattern.is_a?(Regexp) ? number.match?(pattern) : number == pattern
        return false unless predicate
      end
    else
      for number in self
        return false unless number
      end
    end

    true
  end

  def my_any?(pattern = nil)
    if block_given?
      for number in self
        result = yield number
        return true if result
      end
    elsif pattern.is_a? Class
      for number in self
        return true if number.is_a? pattern
      end
    elsif !pattern.nil?
      for number in self
        predicate = pattern.is_a?(Regexp) ? number.match?(pattern) : number == pattern
        return true if predicate
      end
    else
      for number in self
        return true if number
      end
    end
    false
  end

  def my_none?(pattern = nil)
    array = self

    if block_given?
      for number in array
        predicate = yield number
        return false if predicate
      end
    elsif !pattern.nil?
      for number in array
        predicate = pattern.is_a?(Regexp) ? number.match?(pattern) : number == pattern
        return false if predicate
      end
    else
      for number in array
        return false if number
      end
    end

    true
  end

  def my_count(number = nil)
    array = self

    if block_given?
      coincidences = 0
      for item in array
        coincidences += 1 if yield item
      end
      return coincidences
    end

    return array.size if number.nil?

    if number.instance_of?(Integer) || number.instance_of?(Float)
      coincidences = 0
      for item in array
        coincidences += 1 if item == number
      end
      coincidences
    else
      0
    end
  end

  def my_map(proc = nil)
    array = self

    return to_enum unless block_given?

    new_array = []

    if proc.is_a? Proc
      for number in array
        new_number = proc.call number
        new_array.push new_number
      end
      return new_array
    end

    for number in array
      new_number = yield number
      new_array.push new_number
    end

    new_array
  end

  def my_inject(initial_value = nil, symbol = nil)
    array = self
    array = to_a if is_a? Range

    raise LocalJumpError, 'No block or initial acc given' if initial_value.nil? && !block_given?
    return self if array.empty?

    unless initial_value.nil?
      # Only Symbol as an argument
      return get_inject_symbol_result(array, initial_value) if initial_value.is_a? Symbol

      # initial_value and symbol as arguments
      return get_inject_ivalue_symbol array, initial_value, symbol if symbol.is_a? Symbol

      # Only initial_value
      acc = initial_value
      for number in array
        acc = yield acc, number
      end

      return acc
    end

    return self unless block_given?

    # Only block given
    acc = array[0]
    (array.length - 1).times do |i|
      acc = yield acc, array[i + 1]
    end
    acc
  end

  def get_inject_symbol_result(array, symbol)
    acc = array[0]
    (array.length - 1).times do |i|
      acc = acc.send symbol, array[i + 1]
    end
    acc
  end

  def get_inject_ivalue_symbol(array, initial_value, symbol)
    acc = initial_value
    for number in array
      acc = acc.send symbol, number
    end
    acc
  end

  def multiply_els
    array = self
    array.my_inject { |acc, number| acc * number }
  end
end

def multiply_els(array)
  array.my_inject { |acc, number| acc * number }
end

range = Range.new(1, 5)

p range.inject(20, :*)
p range.my_inject(20, :*)

# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Style/For
