require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    if @head == nil # Linked List is empty
      @head = node
      @tail = node
      return
    end

    if @head == @tail # Linked List has one node
      @head.next = node
      @tail = node
      return
    end

    temp = @tail
    temp.next = node
    @tail = node
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head == nil # Linked List is empty
      return
    end

    if @head == @tail # Linked List has one node
      @head = nil
      @tail = nil
      return
    end

    current = @head
    while current != nil && current.next != @tail
      current = current.next
    end

    current.next = nil
    @tail = current
  end

  # This method prints out a representation of the list.
  def print
    output = ""
    if @head == @tail  # Linked List has one node
      output << @head.value + "\n"
    elsif @head != nil  # Linked List has more than one node
      current = @head
      while current != nil && current.next != nil
        output << current.value + "\n"
        current = current.next
      end
      output << current.value + "\n"
    end
    puts output
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if @head == @tail
      if @head == node
        @head = nil
        @tail = nil
      end
    elsif @head != nil
      if @head == node
        @head = node.next
      else
        current = @head
        while current.next != node && current.next != nil
          current = current.next
        end

        if current.next == node
          current.next = node.next
          @tail = current if @tail == node
        end
      end
    end
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
    @head = temp.next
  end

  # This method searches the given location in the Linked List
  def search(location)
    if location == 0
      return @head
    end

    count = 0
    current = @head
    while current != nil && current.next != nil && count != location
      count += 1
      current = current.next
    end

    if count == location
      return current
    end
  end

  # This method returns the number of nodes in the linked list.
  def size
    return 0 if @head == nil

    count = 1
    current = @head
    while current != nil && current.next != nil
      count += 1
      current = current.next
    end
    count
  end
end
