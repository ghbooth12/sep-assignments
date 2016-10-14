include RSpec

require_relative '../binary_tree/node'
require_relative '../min_binary_heap/min_binary_heap'

RSpec.describe MinBinaryHeap, type: Class do
  let (:heap) { MinBinaryHeap.new }

  let (:flipped) { Node.new("Flipped", 55) }
  let (:frozen) { Node.new("Frozen", 89) }
  let (:aladdin) { Node.new("Aladdin", 94) }
  let (:ratatouille) { Node.new("Ratatouille", 96) }
  let (:alice) { Node.new("Alice in Wonderland", 79) }
  let (:beauty) { Node.new("Beauty and the Beast", 93) }
  let (:cinderella) { Node.new("Cinderella", 83) }
  let (:mulan) { Node.new("Mulan", 86) }
  let (:toy_story) { Node.new("Toy Story", 100) }
  let (:shrek) { Node.new("Shrek", 88) }
  let (:dalmatians) { Node.new("101 Dalmatians", 98) }
  let (:panda) { Node.new("Kung Fu Panda", 87) }

  describe "#insert(data)" do
    it "properly inserts a new Data" do
      heap.insert(flipped)
      heap.insert(frozen)
      expect(heap.heapList.last.title).to eq "Frozen"
    end

    it "inserts a Data and swap properly" do
      heap.insert(frozen)
      heap.insert(aladdin)
      heap.insert(flipped)
      expect(heap.heapList.index(flipped)).to eq 1
    end

    it "properly inserts a new Data as a left-left child" do
      heap.insert(shrek)
      heap.insert(cinderella)
      heap.insert(alice)
      heap.insert(panda)
      expect(heap.heapList.last.title).to eq "Shrek"
    end

    it "properly inserts a new Data as a right child" do
      heap.insert(shrek)
      heap.insert(cinderella)
      heap.insert(alice)
      heap.insert(panda)
      expect(heap.heapList[heap.heapList.index(panda)+1].title).to eq "Cinderella"
    end
  end

  describe "#find(data)" do
    it "handles nil gracefully" do
      heap.insert(dalmatians)
      heap.insert(panda)
      expect(heap.find(nil)).to eq nil
    end

    it "properly finds a left Data" do
      heap.insert(flipped)
      heap.insert(frozen)
      expect(heap.find(frozen.title).title).to eq "Frozen"
    end

    it "properly finds a left-left Data" do
      heap.insert(flipped)
      heap.insert(aladdin)
      heap.insert(frozen)
      heap.insert(alice)
      expect(heap.find(aladdin.title).title).to eq "Aladdin"
    end

    it "properly finds a left-right Data" do
      heap.insert(alice)
      heap.insert(beauty)
      heap.insert(dalmatians)
      heap.insert(shrek)
      heap.insert(toy_story)
      heap.insert(flipped)
      expect(heap.find(dalmatians.title).title).to eq "101 Dalmatians"
    end

    it "properly finds a right-right Data" do
      heap.insert(alice)
      heap.insert(beauty)
      heap.insert(dalmatians)
      heap.insert(cinderella)
      heap.insert(shrek)
      heap.insert(toy_story)
      heap.insert(flipped)
      expect(heap.find(dalmatians.title).title).to eq "101 Dalmatians"
    end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(heap.delete(nil)).to eq nil
    end

    it "handles non-existing Data gracefully" do
      heap.insert(flipped)
      heap.insert(shrek)
      expect(heap.delete(aladdin.title)).to eq nil
    end

    it "properly deletes a left Data" do
      heap.insert(shrek)
      heap.insert(ratatouille)
      heap.insert(beauty)
      heap.delete(ratatouille.title)
      expect(heap.find(ratatouille.title)).to be_nil
    end

    it "properly deletes a left-left Data" do
      heap.insert(aladdin)
      heap.insert(toy_story)
      heap.insert(cinderella)
      heap.insert(panda)
      heap.insert(mulan)
      heap.delete(toy_story.title)
      expect(heap.find(toy_story.title)).to be_nil
    end

    it "properly deletes a left-right Data" do
      heap.insert(alice)
      heap.insert(beauty)
      heap.insert(mulan)
      heap.delete(beauty.title)
      expect(heap.find(beauty.title)).to be_nil
    end

    it "properly deletes a right-right Data" do
      heap.insert(dalmatians)
      heap.insert(panda)
      heap.insert(toy_story)
      heap.insert(shrek)
      heap.insert(ratatouille)
      heap.delete(shrek.title)
      expect(heap.find(shrek.title)).to be_nil
    end
  end

  describe "#printf" do
    specify {
      expected_output = "Flipped: 55\nAlice in Wonderland: 79\nCinderella: 83\nMulan: 86\nShrek: 88\nKung Fu Panda: 87\nBeauty and the Beast: 93\nRatatouille: 96\nToy Story: 100\nFrozen: 89\n101 Dalmatians: 98\nAladdin: 94\n"
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
      expect { heap.printf }.to output(expected_output).to_stdout
    }

    specify {
      expected_output = "Flipped: 55\nMulan: 86\nAlice in Wonderland: 79\nKung Fu Panda: 87\nBeauty and the Beast: 93\nAladdin: 94\nCinderella: 83\nFrozen: 89\nShrek: 88\n101 Dalmatians: 98\nToy Story: 100\nRatatouille: 96\n"

      heap.insert(alice)
      heap.insert(panda)
      heap.insert(ratatouille)
      heap.insert(frozen)
      heap.insert(beauty)
      heap.insert(cinderella)
      heap.insert(flipped)
      heap.insert(mulan)
      heap.insert(shrek)
      heap.insert(dalmatians)
      heap.insert(toy_story)
      heap.insert(aladdin)
      expect { heap.printf }.to output(expected_output).to_stdout
    }
  end
end
