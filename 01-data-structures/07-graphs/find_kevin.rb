class FindKevin
  attr_accessor :path
  attr_accessor :paths

  def initialize
    @path = []
    @paths = []
    @queue = []
  end

  # This method verifies if the given 'film' is already visited.
  # If so, it returns true. If not, it returns false.
  def included_film?(film)
    bool = false
    if @path.include?(film) # if current path includes film
      bool = true
    end
    unless @paths.empty?
      for path in @paths
        if path.include?(film) # if any past paths include film
          if @path[-1] == film && @path.length != 1
            @path.pop # remove the film which it already visited.
          end
          bool = true
        end
      end
    end
    bool
  end

  # This method returns the path which has the shortest length out of the given 'paths' array.
  def shortest_path(paths)
    l = paths[0].length
    shortest = paths[0]
    for i in 1...paths.length
      if l > paths[i].length
        l = paths[i].length
        shortest = paths[i]
      end
    end
    shortest
  end

  # This method add the newly found @path into the @paths array.
  # Just using @paths.push(@path) will be a problem in the included_film?(film) when it 'pop's the @path.
  # When it 'pop's the @path, it also 'pop's the path which is inside @paths array.
  def add_path
    index = @paths.length
    @paths[index] = []
    for i in @path
      @paths[index] << i
    end
    @path.pop
  end

  # This method finds the shortest path to 'Kevin Bacon' node.
  def find_kevin_bacon(start, kevin)
    return @path if start == kevin

    @queue << start
    for film in start.film_actor_hash.keys
      if !included_film?(film)
        @path.push(film)
        if start.film_actor_hash[film].include?(kevin)
          add_path # Adds the new path into @paths
          break
        else
          for actor in start.film_actor_hash[film]
            find_kevin_bacon(actor, kevin) # Recursion!
          end
        end
      end
    end

    @queue.pop
    # When it comes back to the node where it first started searching,
    # it empties the @path array so it can start adding a new film
    # But it only empties when @path at least has one film,
    # otherwise it will keep emptying @path array until @queue contains at least two actors.
    @path = [] if @queue.length == 1 && @path.length > 1
    return shortest_path(@paths) unless @paths.empty?
  end
end
