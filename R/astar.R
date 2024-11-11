library(igraph)

# Node class to represent each point on the grid
create_node <- function(x, y, g = 0, h = 0, parent = NULL) {
  list(x = x, y = y, g = g, h = h, f = g + h, parent = parent)
}

# Heuristic function based on Manhattan distance
heuristic <- function(node, goal) {
  abs(node$x - goal$x) + abs(node$y - goal$y)
}

# A* function
astar <- function(start, goal, grid) {
  open_set <- list(start)
  closed_set <- list()
  path <- list()
  
  while (length(open_set) > 0) {
    open_set <- open_set[order(sapply(open_set, function(n) n$f))]
    current <- open_set[[1]]
    open_set <- open_set[-1]
    
    if (current$x == goal$x && current$y == goal$y) {
      while (!is.null(current$parent)) {
        path <- c(list(c(current$x, current$y)), path)
        current <- current$parent
      }
      return(do.call(rbind, path))
    }
    
    closed_set <- c(closed_set, list(current))
    
    neighbors <- list(
      create_node(current$x + 1, current$y),
      create_node(current$x - 1, current$y),
      create_node(current$x, current$y + 1),
      create_node(current$x, current$y - 1)
    )
    
    for (neighbor in neighbors) {
      if (neighbor$x < 1 || neighbor$y < 1 || neighbor$x > nrow(grid) || neighbor$y > ncol(grid) || grid[neighbor$x, neighbor$y] == 1) {
        next
      }
      
      if (any(sapply(closed_set, function(n) n$x == neighbor$x && n$y == neighbor$y))) {
        next
      }
      
      neighbor$g <- current$g + 1
      neighbor$h <- heuristic(neighbor, goal)
      neighbor$f <- neighbor$g + neighbor$h
      neighbor$parent <- current
      
      if (!any(sapply(open_set, function(n) n$x == neighbor$x && n$y == neighbor$y && n$f <= neighbor$f))) {
        open_set <- c(open_set, list(neighbor))
      }
    }
  }
  return(NULL)  # No path found
}

# Example usage:
grid <- matrix(c(
  0, 1, 0, 0,
  0, 1, 0, 1,
  0, 0, 0, 1,
  1, 0, 0, 0
), nrow = 4, byrow = TRUE)

start <- create_node(1, 1)
goal <- create_node(4, 4)
path <- astar(start, goal, grid)
print("Path:")
print(path)
