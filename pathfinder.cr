class Pathfinder2
  alias Node = NamedTuple(x: Int32, y: Int32)
  property grid : Array(Array(Int32))

  def initialize(grid : Array(Array(Int32)))
    @grid = grid.clone

    @start = Point.new 0, 0
    @dest = Point.new 0, 0
  end

  def start(x : Int32, y : Int32)
    @start.x = x
    @start.y = y
  end

  def dest(x : Int32, y : Int32)
    @dest.x = x
    @dest.y = y
  end

  def search
    queue = Deque(Node).new
    visited = Deque(Node).new
    parents = Hash(Node, Node).new

    start = {x: @start.x, y: @start.y}

    queue << start

    current = start

    path_found = false
    while queue.size > 0
      current = queue.shift
      visited << current

      if current[:x] == @dest.x && current[:y] == @dest.y
        path_found = true
        break
      end

      nb = neighbours(current)

      nb.each do |x, y|
        node = {x: x, y: y}
        if !visited.includes?(node) && !queue.includes?(node)
          queue << node
          parents[node] = current
        end
      end
    end

    path = Array(Node).new
    if path_found == false
      return path
    end

    current = visited.pop
    searching = true
    while searching
      if parents.has_key? current
        path << current
        current = parents[current]
      else
        searching = false
      end
    end
    path.reverse
  end

  # Returns a list of positions that surround the current node,
  # are empty (value = 1),
  # and within the bounds of the @grid.
  def neighbours(node)
    x = node[:x]
    y = node[:y]
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}].select do |x1, y1|
      x1 >= 0 && x1 < @grid.size && y1 >= 0 && y1 < @grid[0].size && @grid[x1][y1] == 1
    end
  end

  protected def within_boundary_of?(x, y, grid)
    x >= 0 && x < grid.size && y >= 0 && y < grid[0].size
  end

  class Point
    property x, y

    def initialize(@x : Int32, @y : Int32)
    end
  end
end
