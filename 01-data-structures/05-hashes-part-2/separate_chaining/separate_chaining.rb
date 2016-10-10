require_relative 'node'
require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @hash_array = Array.new(size){LinkedList.new}
  end

  def []=(key, value)
    llist = @hash_array[index(key, size)]
    node = Node.new(key, value)

    if llist.head
      while llist.size == size
        resize
        llist = @hash_array[index(key, size)]
      end
      llist.add_to_tail(node)
    else
      llist.head = node
      llist.tail = node
    end
  end

  def [](key)
    llist = @hash_array[index(key, size)]

    current = llist.head
    for i in 1..llist.size
      if current.key == key
        return current.value
      end
      current = current.next
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    sum = 0
    @hash_array.each do |llist|
      sum += llist.size
    end
    lf = sum / size.to_f

    while lf > @max_load_factor
      resize
      sum = 0
      @hash_array.each do |llist|
        sum += llist.size
      end
      lf = sum / size.to_f
    end
    lf
  end

  # Simple method to return the number of items in the hash
  def size
    @hash_array.length
  end

  # Resize the hash
  def resize
    new_size = size * 2
    temp = @hash_array
    @hash_array = Array.new(new_size){LinkedList.new}

    temp.each do |llist|
      current = llist.head
      for i in 1..llist.size
        new_llist = @hash_array[index(current.key, size)]
        new_llist.add_to_tail(current)
        current = current.next
      end
    end
  end
end
