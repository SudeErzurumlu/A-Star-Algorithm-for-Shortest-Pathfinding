# A* Pathfinding Algorithm in R

### Description
This R implementation of the A* (A-Star) algorithm finds the shortest path between two points on a grid using a heuristic function. Primarily applied in AI and robotics, this version enables efficient pathfinding across a customizable grid layout.

### Quick Start
1. Place `astar.R` in your working directory.
2. Run the script, specifying the `grid`, `start`, and `goal` nodes as shown below:

   ```r
   # Load astar.R file
   source("astar.R")
   
   # Define grid (0: path, 1: obstacle)
   grid <- matrix(c(
       0, 1, 0, 0,
       0, 1, 0, 1,
       0, 0, 0, 1,
       1, 0, 0, 0
   ), nrow = 4, byrow = TRUE)
   
   start <- create_node(1, 1)
   goal <- create_node(4, 4)
   
   # Find path
   path <- astar(start, goal, grid)
   print("Path:")
   print(path)
   ```
   
### Features
- Heuristic Flexibility: Utilizes Manhattan distance, adjustable for different search requirements.
- Configurable Grid: Allows variable sizes and layouts, with obstacles and free paths easily managed.
