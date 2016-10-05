class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue[0]
  end

  def enqueue(element)
    @queue = [element] + @queue
    @head = @queue[0]
    @tail = @queue[-1]
  end

  def dequeue
    if @queue.length == 1
      @queue = []
    else
      @queue = @queue[0..@queue.length - 2]
    end
    @head = @queue[0]
    @tail = @queue[-1]
  end

  def empty?
    @queue.length == 0
  end
end
