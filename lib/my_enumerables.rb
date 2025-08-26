module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for ele in self
      yield(ele)
    end
    self
  end

  def my_each_with_index
    self.size.times do |number|
      yield(self[number], number)
    end
    self
  end

  def my_select
    found_values = []
    self.my_each do |ele|
      found_values.push(ele) if yield(ele)
    end
    found_values
  end

  def my_all?
    self.my_each do |ele|
      return false unless yield(ele)
    end
    true
  end

  def my_any?
    self.my_each do |ele|
      return true if yield(ele)
    end
    false
  end

  def my_none?
    self.my_each do |ele|
      return false if yield(ele)
    end
    return true
  end

  def my_count
    if block_given?
      current_count = 0
      self.my_each do |ele|
        current_count += 1 if yield(ele)
      end
      return current_count
    end
    self.size
  end

  def my_map
    final_arr = []
    self.my_each do |ele|
      final_arr.push(yield(ele))
    end
    final_arr
  end

  def my_inject(initial_value=nil)
    accumulator = initial_value
    if initial_value == nil
      accumulator = self.first
      self[1..].my_each do |ele|
        accumulator = yield(accumulator, ele)
      end
    else
      self.my_each do |ele|
        accumulator = yield(accumulator, ele)
      end
    end
    accumulator
  end
end
