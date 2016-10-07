require_relative  'hash_item'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, @items.length)

    while @items[i] != nil && @items[i].value != value
      resize
    end

    @items[i] = HashItem.new(key, value)
  end

  def [](key)
    i = index(key, @items.length)
    if @items[i] != nil
      @items[i].value
    end
  end

  def resize
    copy = @items

    new_size = @items.length * 2
    @items = Array.new(new_size)

    copy.each {|node|
      if node != nil
        new_i = index(node.key, @items.length)
        @items[new_i] = node
      end
    }
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    asc = key.sum
    asc % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end
end
