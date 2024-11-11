import heapq

class Node:
    def __init__(self, x, y, g=0, h=0):
        self.x = x
        self.y = y
        self.g = g  # Movement cost from start to current node
        self.h = h  # Heuristic cost to reach goal
        self.f = g + h  # Total cost
        self.parent = None  # Tracks the path

    def __lt__(self, other):
        return self.f < other.f

def heuristic(node, goal):
    """Calculate the heuristic based on Manhattan distance."""
    return abs(node.x - goal.x) + abs(node.y - goal.y)

def astar(start, goal, grid):
    open_set = []
    closed_set = set()
    heapq.heappush(open_set, (0, start))
    
    while open_set:
        _, current = heapq.heappop(open_set)
        
        if (current.x, current.y) == (goal.x, goal.y):
            path = []
            while current:
                path.append((current.x, current.y))
                current = current.parent
            return path[::-1]  # Return reversed path
        
        closed_set.add((current.x, current.y))
        
        # Explore neighbors
        for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:  # Up, Down, Left, Right
            nx, ny = current.x + dx, current.y + dy
            if 0 <= nx < len(grid) and 0 <= ny < len(grid[0]) and grid[nx][ny] == 0:
                neighbor = Node(nx, ny, current.g + 1)
                neighbor.h = heuristic(neighbor, goal)
                neighbor.f = neighbor.g + neighbor.h
                neighbor.parent = current
                
                if (neighbor.x, neighbor.y) in closed_set:
                    continue
                
                heapq.heappush(open_set, (neighbor.f, neighbor))
    
    return None  # No path found
