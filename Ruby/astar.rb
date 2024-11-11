# A* Pathfinding Algorithm in Ruby
# This script finds the shortest path on a grid from a starting point to a goal.

class Node
  attr_accessor :position, :g_cost, :h_cost, :f_cost, :parent

  def initialize(position, g_cost, h_cost, parent = nil)
    @position = position
    @g_cost = g_cost
    @h_cost = h_cost
    @f_cost = g_cost + h_cost
    @parent = parent
  end
end

def heuristic(point, goal)
  # Manhattan distance as heuristic
  (point[0] - goal[0]).abs + (point[1] - goal[1]).abs
end

def astar(grid, start, goal)
  open_set = []
  closed_set = Array.new(grid.size) { Array.new(grid[0].size, false) }
  start_node = Node.new(start, 0, heuristic(start, goal))
  open_set.push(start_node)

  until open_set.empty?
    current_node = open_set.min_by(&:f_cost)
    return reconstruct_path(current_node) if current_node.position == goal

    open_set.delete(current_node)
    closed_set[current_node.position[0]][current_node.position[1]] = true

    neighbors(current_node.position, grid).each do |neighbor_pos|
      next if closed_set[neighbor_pos[0]][neighbor_pos[1]] || grid[neighbor_pos[0]][neighbor_pos[1]] == 1

      tentative_g_cost = current_node.g_cost + 1
      neighbor_node = Node.new(neighbor_pos, tentative_g_cost, heuristic(neighbor_pos, goal), current_node)

      if open_set.none? { |node| node.position == neighbor_pos && node.g_cost <= tentative_g_cost }
        open_set.push(neighbor_node)
      end
    end
  end
  raise 'No path found'
end

def neighbors(position, grid)
  row, col = position
  [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]].select do |r, c|
    r.between?(0, grid.size - 1) && c.between?(0, grid[0].size - 1)
  end
end

def reconstruct_path(node)
  path = []
  while node
    path << node.position
    node = node.parent
  end
  path.reverse
end

# Example usage:
grid = [
  [0, 1, 0, 0],
  [0, 1, 0, 1],
  [0, 0, 0, 1],
  [1, 0, 0, 0]
]

start = [0, 0]
goal = [3, 3]

path = astar(grid, start, goal)
puts "Path: #{path.inspect}"
