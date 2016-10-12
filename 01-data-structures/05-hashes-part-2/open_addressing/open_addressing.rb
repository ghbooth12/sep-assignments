require_relative 'node'

class OpenAddressing
  def initialize(size)
    @hash_array = Array.new(size)
  end

  def []=(key, value)
    new_i = next_open_index(index(key, size))
    while new_i == -1
      resize
      new_i = next_open_index(index(key, size))
    end
    @hash_array[new_i] = Node.new(key, value)
  end

  def [](key)
    @hash_array.each do |node|
      if !node.nil? && node.key == key
        return node.value
      end
    end
    nil
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    for j in index...size
      return j if @hash_array[j].nil?
    end
    for k in 0...index
      return k if @hash_array[k].nil?
    end
    -1
  end

  # Simple method to return the number of items in the hash
  def size
    @hash_array.length
  end

  # Resize the hash
  def resize
    temp = @hash_array
    @hash_array = Array.new(size * 2)

    temp.each do |n|
      if !n.nil?
        new_i = next_open_index(index(n.key, size))
        @hash_array[new_i] = n
      end
    end
  end
end
