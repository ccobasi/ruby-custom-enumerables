# rubocop:disable Style/For
# Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# Metrics/ModuleLength
module Enumerable
  def my_each
    array = self

    return array unless block_given?

    for i in array do
      yield i
    end

    array
  end

  def my_each_with_index
    array = self

    return array unless block_given?

    array.length.times do |i|
      yield array[i], i
    end

    array
  end

  def my_select
    array = self

    return array unless block_given?

    new_array = []

    for number in array
      was_selected = yield number
      new_array.push number if was_selected
    end

    new_array
  end

  def my_all?
    array = self

    if block_given?
      for number in array
        predicate = yield number
        return false unless predicate
      end
    else
      for number in array
        return false unless number
      end
    end

    true
  end

  def my_any?
    array = self

    if block_given?
      for number in array
        result = yield number
        return true if result
      end
    else
      for number in array
        return true if number
      end
    end
    false
  end

  def my_none?
    array = self

    if block_given?
      for number in array
        predicate = yield number
        return false unless predicate
      end
    else
      for number in array
        return false unless number
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

    return array.length if number.nil?

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

  def my_map(&block)
    array = self

    return array unless block_given?

    new_array = []

    for number in array
      new_number = block.call number
      new_array.push new_number
    end

    new_array
  end

  def my_inject(initial_value = nil)
    array = self

    return array unless block_given?
    return array if array.empty?

    unless initial_value.nil?
      acc = initial_value
      for number in array
        acc = yield acc, number
      end
      acc
    end

    acc = array[0]
    (array.length - 1).times do |i|
      acc = yield acc, array[i + 1]
    end
    acc
  end

  def multiply_els
    array = self
    array.my_inject { |acc, number| acc * number }
  end
end
