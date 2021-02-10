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

  def my_count
    array = self
    array_length = 0
    
  
    for item in array
      array_length += 1
      return array_length
    end

  elsif block_given?
    for item in array.any?
      array_length += 1
    end



  end


end


p [1,5,3,7,6,8,9].count { |number| number}

p [1,5,3,7,6,8,9].my_count { |number| number}

