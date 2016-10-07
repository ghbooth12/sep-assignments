require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    if @head == nil
      @head = node
    else
      @tail.next = node
    end

    @tail = node
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head == @tail
      @head = nil
      @tail = nil
    else
      previous = @head
      current = previous.next

      while current.next != nil
        previous = current
        current = current.next
      end

      @tail = previous
    end
  end

  # This method prints out a representation of the list.
  def print
    if @head == @tail
      puts "#{@head.data}\n"
      return
    end

    previous = @head
    current = previous.next
    output = "#{@head.data}\n"

    while current.next != nil
      output += "#{current.data}\n"
      previous = current
      current = current.next
    end
    output += "#{@tail.data}\n"
    puts output
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    return if @head == nil

    if @head == node
      @head = node.next
      return
    end

    current = @head
    while current.next != node && current.next != nil
      current =  current.next
    end
    current.next = node.next

    @tail = current if current.next == nil
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    temp = @head
    @head = node
    @head.next = temp
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    temp = @head
    @head = @head.next
    return temp
  end

  # This method returns the node at the given location.
  def search(location)
    return if @head == nil

    count = 0
    node = @head

    while count != location && node.next != nil
      count += 1
      node = node.next
    end
    return node
  end
end
