class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    @stack[@stack.length] = item
    self.top = @stack[-1]
  end

  def pop
    remove = @stack[-1]
    if @stack.length == 1
      @stack = []
    else
      @stack = @stack[0..@stack.length - 2]
    end
    self.top = @stack[-1]
    remove
  end

  def empty?
    @stack.length == 0
  end
end
