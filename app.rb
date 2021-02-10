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

  end

end


p [].all? { |number| number.negative? }

p [].my_all? { |number| number.negative? }
