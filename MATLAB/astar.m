function path = astar(grid, start, goal)
    % A* Pathfinding Algorithm in MATLAB
    % Inputs:
    %   grid  - Matrix representing the map (0: path, 1: obstacle)
    %   start - Starting point in format [row, col]
    %   goal  - Goal point in format [row, col]
    % Output:
    %   path  - List of points representing the shortest path from start to goal
    
    [rows, cols] = size(grid);
    openSet = [start, 0, heuristic(start, goal), heuristic(start, goal)];
    closedSet = zeros(size(grid));
    cameFrom = cell(size(grid));
    
    % A* Loop
    while ~isempty(openSet)
        [~, idx] = min(openSet(:, 4)); % Find the node with lowest f cost
        current = openSet(idx, 1:2);
        
        if isequal(current, goal)
            path = reconstruct_path(cameFrom, current, start);
            return;
        end
        
        openSet(idx, :) = []; % Remove current from openSet
        closedSet(current(1), current(2)) = 1;
        
        % Check all neighbors (4-directional movement)
        for d = [-1 0; 1 0; 0 -1; 0 1]'
            neighbor = current + d';
            if neighbor(1) < 1 || neighbor(1) > rows || neighbor(2) < 1 || neighbor(2) > cols
                continue;
            end
            if grid(neighbor(1), neighbor(2)) == 1 || closedSet(neighbor(1), neighbor(2)) == 1
                continue;
            end
            
            tentative_gScore = heuristic(current, start) + 1;
            if ~ismember(neighbor, openSet(:, 1:2), 'rows')
                cameFrom{neighbor(1), neighbor(2)} = current;
                fScore = tentative_gScore + heuristic(neighbor, goal);
                openSet = [openSet; neighbor, tentative_gScore, heuristic(neighbor, goal), fScore];
            end
        end
    end
    error('No path found');
end

function h = heuristic(point, goal)
    % Heuristic function using Manhattan distance
    h = abs(point(1) - goal(1)) + abs(point(2) - goal(2));
end

function path = reconstruct_path(cameFrom, current, start)
    % Reconstruct path from goal to start
    path = current;
    while ~isequal(current, start)
        current = cameFrom{current(1), current(2)};
        path = [current; path];
    end
end
