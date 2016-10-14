require_relative '../binary_tree/node'

class MinBinaryHeap
  attr_accessor :heapList
  attr_accessor :currentSize

  def initialize
    @heapList = [0]
    @currentSize = 0
  end

  def insert(node)
    @heapList << node
    @currentSize += 1
    moveUp(@currentSize)
  end

  def find(title)
    @heapList[1..-1].select{|x|x.title == title}[0]
  end

  def delete(title)
    node = find(title)
    if node.nil? || !@heapList.include?(node)
      return
    end

    i = @heapList.index(node)
    @heapList[i] = @heapList[@currentSize] # recently added node takes empty root spot
    @currentSize -= 1 # the recently added node moved, remove its old spot
    @heapList.pop
    moveDown(i)
  end

  def printf
    str = ''
    @heapList[1..-1].each {|x|
      str << "#{x.title}: #{x.rating}\n"
    }
    puts str
  end

  private

  def minChild(i)
    # if right child node's index is greater than the total number of nodes == right child node does not exist
    # that is why it doesn't go to the next if statement to compare with right node
    if i * 2 + 1 > @currentSize
        return i * 2 # get left child node
    else
      # heapList[i]'s two child nodes: heapList[i*2], heapList[i*2+1]
      if @heapList[i * 2].rating < @heapList[i * 2 + 1].rating
        return i * 2 # left node is smaller than right
      else
        return i * 2 + 1 # right node is smaller than left
      end
    end
  end

  def moveUp(i)   # heapList[i]: node newly added
    while i / 2 > 0 # heapList[i / 2]: node newly added's parent
      if @heapList[i].rating < @heapList[i / 2].rating # if child is smaller
        tmp = @heapList[i / 2] # swap with parent
        @heapList[i / 2] = @heapList[i]
        @heapList[i] = tmp
      end
      i /= 2 # move up to parent's parent
    end
  end

  def moveDown(i) # @heapList[i*2] is child node of heapList[i]
    while (i * 2) <= @currentSize # while @heapList[i*2] is NOT a leaf node
      min_child = minChild(i) # get the smallest node
      if @heapList[i].rating > @heapList[min_child].rating # if parent is greater than child
        tmp = @heapList[i] # swap parent with child
        @heapList[i] = @heapList[min_child]
        @heapList[min_child] = tmp
      end
      i = min_child # move down to the smallest child
    end
  end
end
