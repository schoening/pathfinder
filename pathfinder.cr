class Pathfinder
  property allow_diagonals : Bool

  def initialize(grid : Array(Array(Int32)), allow_diagonals = false)
    @graph = Graph.new grid
    @start = {"x" => 0, "y" => 0}
    @dest = {"x" => 0, "y" => 0}
    @allow_diagonals = allow_diagonals
  end

  def start(x, y)
    @start["x"] = x
    @start["y"] = y
  end

  def dest(x, y)
    @dest["x"] = x
    @dest["y"] = y
  end

  protected def generate_path(visited)
    path = Array(Tuple(Int32, Int32)).new
    node = visited.last
    while true
      parent = node.parent
      if parent.nil?
        path << {node.x, node.y}
        break
      else
        path << {node.x, node.y}
        node = parent
      end
    end
    path.reverse
  end

  # TODO:
  # set all parents to nil to avoid potential bugs after more than one search?
  # Still need to verify if this is ever a problem.
  def search
    # Nodes that are in queue to be checked
    todo = Array(Node).new
    visited = Array(Node).new
    #
    node_grid = @graph.grid
    #
    start_node = node_grid[@start["x"]][@start["y"]]
    dest_node = node_grid[@dest["x"]][@dest["y"]]
    #
    todo << start_node
    path = Array(Tuple(Int32, Int32)).new
    while todo.size > 0
      current_node = todo.shift
      visited << current_node

      # Destination found!
      if current_node == dest_node
        return generate_path visited
      end

      x = current_node.x
      y = current_node.y
      # UP
      if within_boundary_of? x, y - 1, node_grid
        node = node_grid[x][y - 1]
        if node.weight != 0
          if !node.inside? visited
            if !node.inside? todo
              todo << node
              node.parent = current_node
            end
          end
        end
      end
      # DOWN
      if within_boundary_of? x, y + 1, node_grid
        node = node_grid[x][y + 1]
        if node.weight != 0
          if !node.inside? visited
            if !node.inside? todo
              todo << node
              node.parent = current_node
            end
          end
        end
      end
      # LEFT
      if within_boundary_of? x - 1, y, node_grid
        node = node_grid[x - 1][y]
        if node.weight != 0
          if !node.inside? visited
            if !node.inside? todo
              todo << node
              node.parent = current_node
            end
          end
        end
      end
      # RIGHT
      if within_boundary_of? x + 1, y, node_grid
        node = node_grid[x + 1][y]
        if node.weight != 0
          if !node.inside? visited
            if !node.inside? todo
              todo << node
              node.parent = current_node
            end
          end
        end
      end
      # TODO: Prevent diagonals at the edges of walls.
      if @allow_diagonals == true
        # NORTH WEST
        if within_boundary_of? x - 1, y - 1, node_grid
          node = node_grid[x - 1][y - 1]
          if node.weight != 0
            if !node.inside? visited
              if !node.inside? todo
                todo << node
                node.parent = current_node
              end
            end
          end
        end
        # NORTH EAST
        if within_boundary_of? x + 1, y - 1, node_grid
          node = node_grid[x + 1][y - 1]
          if node.weight != 0
            if !node.inside? visited
              if !node.inside? todo
                todo << node
                node.parent = current_node
              end
            end
          end
        end
        # SOUTH EAST
        if within_boundary_of? x + 1, y + 1, node_grid
          node = node_grid[x + 1][y + 1]
          if node.weight != 0
            if !node.inside? visited
              if !node.inside? todo
                todo << node
                node.parent = current_node
              end
            end
          end
        end
        # SOUTH WEST
        if within_boundary_of? x - 1, y + 1, node_grid
          node = node_grid[x - 1][y + 1]
          if node.weight != 0
            if !node.inside? visited
              if !node.inside? todo
                todo << node
                node.parent = current_node
              end
            end
          end
        end
      end
    end
    # Returns empty path array
    path
  end

  protected def within_boundary_of?(x, y, grid)
    x >= 0 && x < grid.size && y >= 0 && y < grid[0].size
  end

  class Graph
    property grid : Array(Array(Node))

    def initialize(matrix : Array(Array(Int32)))
      @grid = Array(Array(Node)).new
      matrix.each_with_index do |row, x|
        @grid << Array(Node).new
        row.each_with_index do |col, y|
          @grid[x] << Node.new x, y, nil, col
        end
      end
    end
  end

  class Node
    property x, y, parent, weight

    def initialize(@x : Int32, @y : Int32, @parent : Node | Nil, @weight : Int32)
    end

    def inside?(array)
      array.select { |i| i == self }.size > 0
    end
  end
end
