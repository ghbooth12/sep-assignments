class Helper
  def leaf?(node)
    return node.left || node.right ? false : true
  end

  def remove(node)
    temp = node
    if temp.left
      node = temp.left
      if temp.right
        node.right = temp.right
      end
    elsif !temp.left && temp.right
      node = temp.right
    else
      node = nil
    end
    node
  end

  def format(node)
    "#{node.title}: #{node.rating}\n"
  end
end
