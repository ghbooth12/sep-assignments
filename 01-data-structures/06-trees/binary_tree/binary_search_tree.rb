require_relative 'node'
require_relative 'helper'

class BinarySearchTree

  def initialize(root_node)
    @root_node = root_node
    @helper = Helper.new
    @print_str = @helper.format(@root_node)
    @queue = []
  end

  def insert(root, node)
    current = root
    while !current.nil?
      if current.rating > node.rating
        if current.left.nil?
          current.left = node
          return
        else
          current = current.left
        end
      else
        if current.right.nil?
          current.right = node
          return
        else
          current = current.right
        end
      end
    end
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
end
