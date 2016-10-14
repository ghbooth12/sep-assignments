require_relative 'node'
require_relative 'helper'

class BinaryHeap

  def initialize(root_node)
    @helper = Helper.new
  end

  def insert(root, node)
    queue = []
    current = root
    while current.left && current.right
      queue.unshift(current.left)
      queue.unshift(current.right)
      predecessor = queue.pop
      current = predecessor
    end

    if current.left.nil?
      current.left = node
    else
      current.right = node
    end
    swap(root, node)

    # temp = node
    # while root != temp
    #   min_node = min?(node)
    #   if min_node == -1
    #     node = node.left
    #     current.left = temp
    #   elsif min_node == 1
    #     current = current.right
    #     current.right = temp
    #   end
    #   if p_node = find_parent(root, current)
    #     temp = p_node
    #   end
    # end
  end

  # Recursive Depth First Search
  def find(root, data)
    return if data.nil?

    current = root
    while !current.nil?
      if current.title == data
        return current
      else
        if current.left
          current = current.left
        else
          break
        end
      end
    end

    if current && current.left.nil? && current.right
      find(current.right, data)
    end
  end

  def delete(root, data)
    return if data.nil?

    current = root
    while current && current.left && current.left.title != data
      if @helper.leaf?(current.left)
        break
      else
        current = current.left
      end
    end

    if current && current.left && current.left.title == data
      current.left = @helper.remove(current.left)
    elsif current && current.right
      if current.right.title == data
        current.right = @helper.remove(current.right)
      else
        delete(current.right, data)
      end
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    if children.nil?
      children = @root_node
      @queue.unshift(children)
    end

    @queue.pop
    if children.left
      @print_str << @helper.format(children.left)
      @queue.unshift(children.left)
    end
    if children.right
      @print_str << @helper.format(children.right)
      @queue.unshift(children.right)
    end

    if !@queue.empty?
      printf(@queue[-1])
    else
      puts @print_str
    end
  end

  private

  def swap(root, current)
    min_node = @helper.min?(current)
    temp = current
    if min_node == -1
      current = current.left
      current.left = temp
    elsif min_node == 1
      current = current.right
      current.right = temp
    end
    puts "current: " + current.title
    puts "left: " + current.left.title if current.left
    puts "temp: " + temp.title
    return if root == temp
    if p_node = @helper.find_parent(root, current)
      swap(root, p_node)
    end
  end
end
