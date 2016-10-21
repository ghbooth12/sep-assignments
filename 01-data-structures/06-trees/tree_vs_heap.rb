require 'benchmark'
require_relative 'binary_tree/node'
require_relative 'binary_tree/binary_search_tree'
require_relative 'min_binary_heap/min_binary_heap'

class TreeVSHeap
  def initialize
    @root = Node.new("some_word", 15)
    @the_node = Node.new("fifty thousandth", 123456)
    @tree = BinarySearchTree.new(@root)
    @heap = MinBinaryHeap.new
  end

  def random_word
    alphabets = ("a".."z").to_a
    return alphabets.sample(3).join
  end

  def random_num
    rand(1_000)
  end

  def compare_insert
    tree_time = Benchmark.realtime do
      49999.times{ @tree.insert(@root, Node.new(random_word, random_num)) }
      @tree.insert(@root, @the_node)
      50000.times{ @tree.insert(@root, Node.new(random_word, random_num)) }
    end

    heap_time = Benchmark.realtime do
      49999.times{ @heap.insert(Node.new(random_word, random_num)) }
      @heap.insert(@the_node)
      50000.times{ @heap.insert(Node.new(random_word, random_num)) }
    end

    puts "Tree time for inserting: #{tree_time} seconds"
    puts "Heap time for inserting: #{heap_time} seconds"
    puts printTimes(tree_time, heap_time)
  end

  def compare_find
    tree_time = Benchmark.realtime do
      1.times{ @tree.find(@root, @the_node.title) }
    end

    heap_time = Benchmark.realtime do
      1.times{ @heap.find(@the_node.title) }
    end

    puts "Tree time for finding: #{tree_time} seconds"
    puts "Heap time for finding: #{heap_time} seconds"
    puts printTimes(tree_time, heap_time)
  end

  def compare_delete
    tree_time = Benchmark.realtime do
      1.times{ @tree.delete(@root, @the_node.title) }
    end

    heap_time = Benchmark.realtime do
      1.times{ @heap.find(@the_node.title) }
    end

    puts "Tree time for deleting: #{tree_time} seconds"
    puts "Heap time for deleting: #{heap_time} seconds"
    puts printTimes(tree_time, heap_time)
  end

  private

  def printTimes(tree_time, heap_time)
    if tree_time < heap_time
      return "Binary Tree is #{heap_time / tree_time.to_f} times faster than Binary Heap."
    elsif tree_time > heap_time
      return "Binary Heap is #{tree_time / heap_time.to_f} times faster than Binary Tree."
    end
  end
end

vs = TreeVSHeap.new
vs.compare_insert
vs.compare_find
vs.compare_delete
