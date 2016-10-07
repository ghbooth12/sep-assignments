require 'benchmark'
require_relative 'node'
require_relative 'linked_list'

class ArrayVSLinkedList
  def initialize
    @array = []
    @linked_list = LinkedList.new
  end

  def random_word
    alphabets = ("a".."z").to_a
    return alphabets.sample(3).join
  end

  def compare_add
    array_time = Benchmark.realtime do
      10_000.times{ @array.push(random_word)}
    end
    linked_list_time = Benchmark.realtime do
      10_000.times{ @linked_list.add_to_tail(Node.new(random_word)) }
    end

    puts "Array time for adding: #{array_time} seconds"
    puts "Linked List time for adding: #{linked_list_time} seconds"
  end

  def compare_search
    array_time = Benchmark.realtime do
      1.times{ @array[5000] }
    end
    linked_list_time = Benchmark.realtime do
      1.times{ @linked_list.search(5000) }
    end

    puts "Array time for searching: #{array_time} seconds"
    puts "Linked List time for searching: #{linked_list_time} seconds"
  end

  def compare_remove
    array_time = Benchmark.realtime do
      1.times{ @array.delete_at(5000) }
    end
    linked_list_time = Benchmark.realtime do
      1.times{
        node = @linked_list.search(5000)
        @linked_list.delete(node)
      }
    end

    puts "Array time for removing: #{array_time} seconds"
    puts "Linked List time for removing: #{linked_list_time} seconds"
  end
end

vs = ArrayVSLinkedList.new
vs.compare_add
vs.compare_search
vs.compare_remove
