require_relative 'node'

Kevin_Bacon = Node.new("Kevin Bacon")
Dianne_Wiest = Node.new("Dianne Wiest")
Chris_Penn = Node.new("Chris Penn")
Johnny_Depp = Node.new("Johnny Depp")
Winona_Ryder = Node.new("Winona Ryder")
Freddie_Highmore = Node.new("Freddie Highmore")
AnnaSophia_Robb = Node.new("AnnaSophia Robb")
Carrie_Underwood = Node.new("Carrie Underwood")
Dennis_Quaid = Node.new("Dennis Quaid")
John_Goodman = Node.new("John Goodman")
Wayne_Knight = Node.new("Wayne Knight")
Kevin_Costner = Node.new("Kevin Costner")
Lindsay_Lohan = Node.new("Lindsay Lohan")
Natasha_Richardson = Node.new("Natasha Richardson")
Rachel_McAdams = Node.new("Rachel McAdams")
Amanda_Seyfried = Node.new("Amanda Seyfried")
Ryan_Gosling = Node.new("Ryan Gosling")
James_Garner = Node.new("James Garner")
Sarah_Jessica_Parker = Node.new("Sarah Jessica Parker")


Dianne_Wiest.film_actor_hash["Edward Scissorhands"] = [Johnny_Depp, Winona_Ryder]
Dianne_Wiest.film_actor_hash["Footloose"] = [Kevin_Bacon, Chris_Penn, Sarah_Jessica_Parker]

Chris_Penn.film_actor_hash["Footloose"] = [Dianne_Wiest, Kevin_Bacon, Sarah_Jessica_Parker]

Sarah_Jessica_Parker.film_actor_hash["Footloose"] = [Dianne_Wiest, Kevin_Bacon, Chris_Penn]

Johnny_Depp.film_actor_hash["Charlie and the Chocolate Factory"] = [Freddie_Highmore, AnnaSophia_Robb]
Johnny_Depp.film_actor_hash["Edward Scissorhands"] = [Dianne_Wiest, Winona_Ryder]

Winona_Ryder.film_actor_hash["Edward Scissorhands"] = [Johnny_Depp, Dianne_Wiest]

Freddie_Highmore.film_actor_hash["Charlie and the Chocolate Factory"] = [Johnny_Depp, AnnaSophia_Robb]

AnnaSophia_Robb.film_actor_hash["Charlie and the Chocolate Factory"] = [Johnny_Depp, Freddie_Highmore]
AnnaSophia_Robb.film_actor_hash["Soul Surfer"] = [Carrie_Underwood, Dennis_Quaid]

Carrie_Underwood.film_actor_hash["Soul Surfer"] = [AnnaSophia_Robb, Dennis_Quaid]

Dennis_Quaid.film_actor_hash["Soul Surfer"] = [AnnaSophia_Robb, Carrie_Underwood]
Dennis_Quaid.film_actor_hash["Everybody's All-American"] = [John_Goodman, Wayne_Knight]
Dennis_Quaid.film_actor_hash["The Parent Trap"] = [Lindsay_Lohan, Natasha_Richardson]

John_Goodman.film_actor_hash["Everybody's All-American"] = [Dennis_Quaid, Wayne_Knight]

Wayne_Knight.film_actor_hash["JFK"] = [Kevin_Costner, Kevin_Bacon]

Kevin_Costner.film_actor_hash["JFK"] = [Wayne_Knight, Kevin_Bacon]

Lindsay_Lohan.film_actor_hash["The Parent Trap"] = [Dennis_Quaid, Natasha_Richardson]
Lindsay_Lohan.film_actor_hash["Mean Girls"] = [Rachel_McAdams, Amanda_Seyfried]

Rachel_McAdams.film_actor_hash["Mean Girls"] = [Amanda_Seyfried, Lindsay_Lohan]
Rachel_McAdams.film_actor_hash["The Notebook"] = [Ryan_Gosling, James_Garner]

Ryan_Gosling.film_actor_hash["The Notebook"] = [James_Garner, Rachel_McAdams]

James_Garner.film_actor_hash["The Notebook"] = [Rachel_McAdams, Ryan_Gosling]

Amanda_Seyfried.film_actor_hash["Mean Girls"] = [Lindsay_Lohan, Rachel_McAdams]

Natasha_Richardson.film_actor_hash["The Parent Trap"] = [Lindsay_Lohan, Dennis_Quaid]

Wayne_Knight.film_actor_hash["Everybody's All-American"] = [John_Goodman, Dennis_Quaid]

# all_paths = Array.new() # sorted, shortest path at 0, longest at n-1
# start = Freddie_Highmore
# path, path_weight = find_kevin_bacon(start)
# all_paths.push(path)
# shortest_path = all_paths[0]

$path = []
$paths = []

def included_film?(film)
  bool = false
  # if current path includes film
  if $path.include?(film)
    # puts "Already include: #{film}"
    bool = true
  end

  # if any past paths include film
  for path in $paths
    # puts "for loop: #{path}"
    if path.include?(film)
      if $path[-1] == film
        # puts "BEFORE DELETE: #{$path}"
        $path.pop # so it can create new path
        # puts "AFTER DELETE: #{$path}"
      end
      bool = true
    end
  end
  bool
end

def find_shortest(paths)
  l = 10
  for path in paths
    if path.length < l
      l = path.length
      answer = path
    end
  end
  answer
end

def find_kevin_bacon(start)
  # puts "-------------#{start.name}"
  return $path if start == Kevin_Bacon
  return if start.film_actor_hash == {}

  for film in start.film_actor_hash.keys
    # puts film
      if !included_film?(film)
        $path.push(film)
        # puts "pushed: #{film} >> $path: #{$path}"
        if start.film_actor_hash[film].include?(Kevin_Bacon)
          unless $paths.include?($path)
            # Just using $paths.push($path) will be a problem in the included_film?(film).
            index = $paths.length
            $paths[index] = []
            for i in $path
            	$paths[index] << i
            end
          end
          # puts "Added to paths #{$paths}"
        end

        for actor in start.film_actor_hash[film]
          find_kevin_bacon(actor)
        end
      end
  end

  return find_shortest($paths)
end

# p find_kevin_bacon(Ryan_Gosling) # ["The Notebook", "Mean Girls", "The Parent Trap", "Everybody's All-American", "JFK"]
# p find_kevin_bacon(AnnaSophia_Robb) # ["Charlie and the Chocolate Factory", "Edward Scissorhands", "Footloose"]
# p find_kevin_bacon(Wayne_Knight) # ["JFK"]
