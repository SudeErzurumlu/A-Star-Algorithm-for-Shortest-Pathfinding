# A* Pathfinding Algorithm in Python

### Description
This Python implementation of the A* (A-Star) algorithm finds the shortest path between two points on a grid, applying heuristics to enhance search efficiency. Commonly used in AI and game development, A* helps in achieving optimized pathfinding solutions.

### Quick Start
1. Place `astar.py` in your working directory.
2. In your main Python script, use the following structure to find a path:

   ```python
   from astar import Node, astar
   
   # Define grid (0: free path, 1: obstacle)
   grid = [
       [0, 1, 0, 0],
       [0, 1, 0, 1],
       [0, 0, 0, 1],
       [1, 0, 0, 0]
   ]
   
   start = Node(0, 0)
   goal = Node(3, 3)
   
   path = astar(start, goal, grid)
   print("Path:", path)
   ```

### Key Features
- Flexible Heuristic Function: Uses Manhattan distance by default, adaptable to different heuristics.
- Obstacle Navigation: Configurable grid allows for varying obstacle layouts and pathfinding adjustments.
