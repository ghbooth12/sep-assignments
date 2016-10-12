include RSpec

require_relative '../separate_chaining/node'
require_relative '../separate_chaining/linked_list'

RSpec.describe LinkedList, type: Class do
  let(:n1) { Node.new("first", "Rob") }
  let(:n2) { Node.new("second", "Ben") }
  let(:n3) { Node.new("third", "Mike") }
  let(:llist) { LinkedList.new }

  describe "#add_to_tail" do
    it "adds a Node to the tail" do
      llist.add_to_tail(n1)
      expect(llist.tail).to eq n1
      llist.add_to_tail(n2)
      expect(llist.tail).to eq n2
    end
  end

  describe "#remove_tail" do
    it "removes nodes from the tail" do
      llist.add_to_tail(n1)
      llist.add_to_tail(n2)
      expect(llist.tail).to eq n2
      llist.remove_tail
      expect(llist.tail).to eq n1
      llist.remove_tail
      expect(llist.tail).to eq nil
    end
  end

  describe "#print" do
    before do
      llist.add_to_tail(n1)
      llist.add_to_tail(n2)
    end

    specify { expect { llist.print }.to output("Rob\nBen\n").to_stdout }
  end

  describe "#print one element" do
    before do
      llist.add_to_tail(n1)
    end

    specify { expect { llist.print }.to output("Rob\n").to_stdout }
  end

  describe "#delete" do
    before do
      llist.add_to_tail(n1)
      llist.add_to_tail(n2)
      llist.add_to_tail(n3)
    end

    it "removes the head of a list properly" do
      llist.delete(n1)
      expect(llist.head).to eq n2
      expect(llist.head.next).to eq n3
      expect(llist.tail).to eq n3
    end

    it "removes the middle element of a list properly" do
      llist.delete(n2)
      expect(llist.head).to eq n1
      expect(llist.head.next).to eq n3
      expect(llist.tail).to eq n3
    end

    it "removes the last element of a list properly" do
      llist.delete(n3)
      expect(llist.head).to eq n1
      expect(llist.head.next).to eq n2
      expect(llist.tail).to eq n2
    end
  end

  describe "#add_to_front" do
    it "adds the node to the front of the linked list" do
      llist.add_to_front(n1)
      expect(llist.head).to eq n1
      llist.add_to_front(n2)
      expect(llist.head).to eq n2
    end
  end

  describe "#remove_front" do
    it "removes the node to the front of the linked list" do
      llist.add_to_front(n1)
      expect(llist.head).to eq n1
      llist.add_to_front(n2)
      expect(llist.head).to eq n2
      llist.remove_front
      expect(llist.head).to eq n1
      llist.remove_front
      expect(llist.head).to eq nil
    end
  end

  describe "#search" do
    it "returns the node at the given location" do
      llist.add_to_tail(n1)
      llist.add_to_tail(n2)
      llist.add_to_tail(n3)
      expect(llist.search(0)).to eq n1
      expect(llist.search(1)).to eq n2
      expect(llist.search(2)).to eq n3
    end
  end

  describe "#size" do
    it "returns the number of nodes in the linked list" do
      expect(llist.size).to eq 0
      llist.add_to_tail(n1)
      expect(llist.size).to eq 1
      llist.add_to_tail(n2)
      expect(llist.size).to eq 2
      llist.add_to_tail(n3)
      expect(llist.size).to eq 3
    end
  end
end
