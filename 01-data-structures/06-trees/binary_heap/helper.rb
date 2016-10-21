class Helper
  # def leaf?(node)
  #   return node.left || node.right ? false : true
  # end
  #
  # def remove(node)
  #   temp = node
  #   if temp.left
  #     node = temp.left
  #     if temp.right
  #       node.right = temp.right
  #     end
  #   elsif !temp.left && temp.right
  #     node = temp.right
  #   else
  #     node = nil
  #   end
  #   node
  # end
  #
  # def format(node)
  #   "#{node.title}: #{node.rating}\n"
  # end

  def min?(node)
    if node.left && !node.right # only left node exits
      output = node.rating <= node.left.rating ? 0 : -1
    elsif node.left && node.right # both child nodes exist
      if node.rating <= node.left.rating && node.rating <= node.right.rating
        output = 0 # parent node is the smallest
      elsif node.rating > node.left.rating && node.right.rating > node.left.rating
        output = -1 # left node is the smallest
      elsif node.rating > node.right.rating && node.left.rating > node.right.rating
        output = 1 # right node is the smallest
      end
    end
    output
  end

  def find_parent(root, node)
    return if root == node
    return root if root.left == node || root.right == node
    queue = []
    current = root
    while current && current.left != node && current.right != node
      queue.unshift(current.left)
      queue.unshift(current.right)
      predecessor = queue.pop
      current = predecessor
    end
    current
  end

  def swap(root, current)
    min_node = min?(current)
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
    if p_node = find_parent(root, current)
      swap(root, p_node)
    end
  end
end
