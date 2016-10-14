require_relative 'binary_tree/node'
require_relative 'binary_tree/binary_search_tree'
require_relative 'min_binary_heap/min_binary_heap'

# Nodes
flipped = Node.new("Flipped", 55)
frozen = Node.new("Frozen", 89)
aladdin = Node.new("Aladdin", 94)
ratatouille = Node.new("Ratatouille", 96)
alice = Node.new("Alice in Wonderland", 79)
beauty = Node.new("Beauty and the Beast", 93)
cinderella = Node.new("Cinderella", 83)
mulan = Node.new("Mulan", 86)
toy_story = Node.new("Toy Story", 100)
shrek = Node.new("Shrek", 88)
dalmatians = Node.new("101 Dalmatians", 98)
panda = Node.new("Kung Fu Panda", 87)

# Instantiate
tree = BinarySearchTree.new(flipped)
heap = MinBinaryHeap.new


tree.insert(flipped, frozen)
tree.insert(flipped, aladdin)
tree.insert(flipped, ratatouille)
tree.insert(flipped, alice)
tree.insert(flipped, beauty)
tree.insert(flipped, cinderella)
tree.insert(flipped, mulan)
tree.insert(flipped, toy_story)
tree.insert(flipped, shrek)
tree.insert(flipped, dalmatians)
tree.insert(flipped, panda)


heap.insert(flipped)
heap.insert(frozen)
heap.insert(aladdin)
heap.insert(ratatouille)
heap.insert(alice)
heap.insert(beauty)
heap.insert(cinderella)
heap.insert(mulan)
heap.insert(toy_story)
heap.insert(shrek)
heap.insert(dalmatians)
heap.insert(panda)

puts "======== Binary Tree ========"
tree.printf
puts "======== Binary Heap ========"
heap.printf
