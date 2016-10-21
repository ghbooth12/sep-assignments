include RSpec

require_relative '../node'
require_relative '../find_kevin'

RSpec.describe FindKevin, type: Class do
  let(:find) { FindKevin.new }
  let(:kevin_bacon) { Node.new("Kevin Bacon") }
  let(:dianne_wiest) { Node.new("Dianne Wiest") }
  let(:chris_penn) { Node.new("Chris Penn") }
  let(:johnny_depp) { Node.new("Johnny Depp") }
  let(:winona_ryder) { Node.new("Winona Ryder") }
  let(:freddie_highmore) { Node.new("Freddie Highmore") }
  let(:annaSophia_robb) { Node.new("AnnaSophia Robb") }
  let(:carrie_underwood) { Node.new("Carrie Underwood") }
  let(:dennis_quaid) { Node.new("Dennis Quaid") }
  let(:john_goodman) { Node.new("John Goodman") }
  let(:wayne_knight) { Node.new("Wayne Knight") }
  let(:kevin_costner) { Node.new("Kevin Costner") }
  let(:lindsay_lohan) { Node.new("Lindsay Lohan") }
  let(:natasha_richardson) { Node.new("Natasha Richardson") }
  let(:rachel_mcAdams) { Node.new("Rachel McAdams") }
  let(:amanda_seyfried) { Node.new("Amanda Seyfried") }
  let(:ryan_gosling) { Node.new("Ryan Gosling") }
  let(:james_garner) { Node.new("James Garner") }
  let(:sarah_jessica_parker) { Node.new("Sarah Jessica Parker") }
  let(:some_actor) { Node.new("Some Actor") }

  before do
    dianne_wiest.film_actor_hash["Edward Scissorhands"] = [johnny_depp, winona_ryder]
    dianne_wiest.film_actor_hash["Footloose"] = [kevin_bacon, chris_penn, sarah_jessica_parker]

    chris_penn.film_actor_hash["Footloose"] = [dianne_wiest, kevin_bacon, sarah_jessica_parker]

    sarah_jessica_parker.film_actor_hash["Footloose"] = [dianne_wiest, kevin_bacon, chris_penn]

    johnny_depp.film_actor_hash["Charlie and the Chocolate Factory"] = [freddie_highmore, annaSophia_robb]
    johnny_depp.film_actor_hash["Edward Scissorhands"] = [dianne_wiest, winona_ryder]

    winona_ryder.film_actor_hash["Edward Scissorhands"] = [johnny_depp, dianne_wiest]

    freddie_highmore.film_actor_hash["Charlie and the Chocolate Factory"] = [johnny_depp, annaSophia_robb]

    annaSophia_robb.film_actor_hash["Charlie and the Chocolate Factory"] = [johnny_depp, freddie_highmore]
    annaSophia_robb.film_actor_hash["Soul Surfer"] = [carrie_underwood, dennis_quaid]

    carrie_underwood.film_actor_hash["Soul Surfer"] = [annaSophia_robb, dennis_quaid]

    dennis_quaid.film_actor_hash["Soul Surfer"] = [annaSophia_robb, carrie_underwood]
    dennis_quaid.film_actor_hash["Everybody's All-American"] = [john_goodman, wayne_knight]
    dennis_quaid.film_actor_hash["The Parent Trap"] = [lindsay_lohan, natasha_richardson]

    john_goodman.film_actor_hash["Everybody's All-American"] = [dennis_quaid, wayne_knight]

    wayne_knight.film_actor_hash["JFK"] = [kevin_costner, kevin_bacon]

    kevin_costner.film_actor_hash["JFK"] = [wayne_knight, kevin_bacon]

    lindsay_lohan.film_actor_hash["The Parent Trap"] = [dennis_quaid, natasha_richardson]
    lindsay_lohan.film_actor_hash["Mean Girls"] = [rachel_mcAdams, amanda_seyfried]

    rachel_mcAdams.film_actor_hash["Mean Girls"] = [amanda_seyfried, lindsay_lohan]
    rachel_mcAdams.film_actor_hash["The Notebook"] = [ryan_gosling, james_garner]

    ryan_gosling.film_actor_hash["The Notebook"] = [james_garner, rachel_mcAdams]

    james_garner.film_actor_hash["The Notebook"] = [rachel_mcAdams, ryan_gosling]

    amanda_seyfried.film_actor_hash["Mean Girls"] = [lindsay_lohan, rachel_mcAdams]

    natasha_richardson.film_actor_hash["The Parent Trap"] = [lindsay_lohan, dennis_quaid]

    wayne_knight.film_actor_hash["Everybody's All-American"] = [john_goodman, dennis_quaid]
  end

  # The philosophy behind "modular" applications and refactoring into
  # a more modular applications is that you can "unit test" each component.
  # If you know each individual component works properly, then all of the
  # components when combined should work properly together.
  # You want to write tests for each individual component and each component
  # should try to only do "one thing".

  describe "#included_film?(film)" do
    before do
      find.paths = [["Edward Scissorhands", "Soul Surfer", "JFK"]]
      find.path = ["Footloose"]
    end

    it "returns false when the film isn't included" do
      expect(find.included_film?("Charlie and the Chocolate Factory")).to eq false
    end

    it "returns true when the film is included in @path" do
      expect(find.included_film?("Footloose")).to eq true
    end

    it "returns true when the film is included in @paths" do
      expect(find.included_film?("Soul Surfer")).to eq true
    end
  end

  describe "#shortest_path(paths)" do
    before do
      find.paths = [["Edward Scissorhands", "Soul Surfer", "JFK"]]
      find.path = ["Footloose"]
    end

    it "returns false when the film isn't included" do
      expect(find.included_film?("Charlie and the Chocolate Factory")).to eq false
    end

    it "returns true when the film is included in @path" do
      expect(find.included_film?("Footloose")).to eq true
    end

    it "returns true when the film is included in @paths" do
      expect(find.included_film?("Soul Surfer")).to eq true
    end
  end

  describe "#add_path" do
    before do
      find.path = ["Edward Scissorhands", "Soul Surfer", "JFK"]
    end

    it "Adds path to paths properly and 'pop's the path (when paths is empty)" do
      find.add_path
      result_paths = [["Edward Scissorhands", "Soul Surfer", "JFK"]]
      result_path = ["Edward Scissorhands", "Soul Surfer"]
      expect(find.paths).to eq result_paths
      expect(find.path).to eq result_path
    end

    it "Adds path to paths properly and 'pop's the path (when paths is NOT empty)" do
      find.paths = [["movie 1", "movie 2"]]
      find.add_path
      result_paths = [["movie 1", "movie 2"], ["Edward Scissorhands", "Soul Surfer", "JFK"]]
      result_path = ["Edward Scissorhands", "Soul Surfer"]
      expect(find.paths).to eq result_paths
      expect(find.path).to eq result_path
    end
  end

  describe "#find_kevin_bacon(start, kevin)" do
    it "prints the path with 5 movies" do
      result = ["The Notebook", "Mean Girls", "The Parent Trap", "Everybody's All-American", "JFK"]
      expect(find.find_kevin_bacon(ryan_gosling, kevin_bacon)).to eq result
    end

    it "prints the path with 3 movies" do
      result = ["Charlie and the Chocolate Factory", "Edward Scissorhands", "Footloose"]
      expect(find.find_kevin_bacon(annaSophia_robb, kevin_bacon)).to eq result
    end

    it "prints the path with 1 movie" do
      result = ["JFK"]
      expect(find.find_kevin_bacon(wayne_knight, kevin_bacon)).to eq result
    end

    it "prints the shortest path" do
      result = ["Footloose"]
      expect(find.find_kevin_bacon(dianne_wiest, kevin_bacon)).to eq result
    end

    it "handles nil properly" do
      expect(find.find_kevin_bacon(some_actor, kevin_bacon)).to be_nil
    end
  end
end
