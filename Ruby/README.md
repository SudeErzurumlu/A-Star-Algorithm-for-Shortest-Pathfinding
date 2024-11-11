# A* Pathfinding Algorithm in Ruby

### Description
This Ruby script implements the A* algorithm to find the shortest path between two points on a grid. Using a heuristic function based on Manhattan distance, it efficiently navigates around obstacles to find the optimal route.

### Features
- **Heuristic-Based Search**: Uses Manhattan distance for accurate pathfinding.
- **Customizable Grid Layout**: Allows various obstacle configurations for flexible scenarios.

### Usage
1. Save the file as `astar.rb`.
2. Set up a `grid`, where `0` represents open paths and `1` represents obstacles.
3. Define `start` and `goal` points, and then execute the script.

Example:
```ruby
# Grid setup (0 = path, 1 = obstacle)
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
```
