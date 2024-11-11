# A* Pathfinding Algorithm in MATLAB

### Description
This MATLAB implementation of the A* algorithm calculates the shortest path between two points on a grid, utilizing a heuristic function to guide the search. Primarily useful in AI and robotics applications, this algorithm helps find the shortest route across an obstacle-laden grid environment.

### Quick Start
1. Place `astar.m` in your MATLAB working directory.
2. Define a `grid` matrix where `0` represents open paths and `1` represents obstacles.
3. Set the `start` and `goal` points, then run the script as shown below:

   ```matlab
   % Example grid (0: path, 1: obstacle)
   grid = [
       0, 1, 0, 0;
       0, 1, 0, 1;
       0, 0, 0, 1;
       1, 0, 0, 0
   ];
   
   start = [1, 1];
   goal = [4, 4];
   
   % Find path
   path = astar(grid, start, goal);
   disp('Path:');
   disp(path);
   ```

### Features
- Heuristic-Based Efficiency: Uses Manhattan distance for effective pathfinding.
- Flexible Grid Configuration: Customizable grid with obstacle placements for various scenarios.
