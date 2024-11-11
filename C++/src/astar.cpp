#include "astar.h"
#include <queue>
#include <cmath>
#include <algorithm>
#include <iostream>

Node::Node(int x, int y, double g_cost, double h_cost)
    : x(x), y(y), g_cost(g_cost), h_cost(h_cost), parent(nullptr) {}

double Node::f_cost() const {
    return g_cost + h_cost;
}

Astar::Astar(int width, int height) : width(width), height(height) {
    grid.resize(height, std::vector<Node*>(width, nullptr));
}

Astar::~Astar() {
    for (auto& row : grid) {
        for (auto& node : row) {
            delete node;
        }
    }
}

void Astar::initializeNode(int x, int y, double g_cost, double h_cost) {
    if (!grid[y][x]) {
        grid[y][x] = new Node(x, y, g_cost, h_cost);
    }
}

double Astar::heuristic(int x1, int y1, int x2, int y2) {
    // Using Euclidean distance as heuristic
    return std::sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

bool Astar::isValid(int x, int y) {
    return x >= 0 && y >= 0 && x < width && y < height;
}

std::vector<Node*> Astar::getNeighbors(Node* node) {
    std::vector<Node*> neighbors;
    const int dx[] = {1, -1, 0, 0};
    const int dy[] = {0, 0, 1, -1};

    for (int i = 0; i < 4; ++i) {
        int nx = node->x + dx[i];
        int ny = node->y + dy[i];
        if (isValid(nx, ny)) {
            initializeNode(nx, ny, 0, 0);
            neighbors.push_back(grid[ny][nx]);
        }
    }
    return neighbors;
}

std::vector<Node*> Astar::findPath(int startX, int startY, int goalX, int goalY) {
    auto compare = [](Node* a, Node* b) { return a->f_cost() > b->f_cost(); };
    std::priority_queue<Node*, std::vector<Node*>, decltype(compare)> openSet(compare);

    initializeNode(startX, startY, 0, heuristic(startX, startY, goalX, goalY));
    Node* startNode = grid[startY][startX];
    openSet.push(startNode);

    while (!openSet.empty()) {
        Node* current = openSet.top();
        openSet.pop();

        if (current->x == goalX && current->y == goalY) {
            return reconstructPath(current);
        }

        for (Node* neighbor : getNeighbors(current)) {
            double tentative_g = current->g_cost + 1;
            if (tentative_g < neighbor->g_cost || neighbor->g_cost == 0) {
                neighbor->g_cost = tentative_g;
                neighbor->h_cost = heuristic(neighbor->x, neighbor->y, goalX, goalY);
                neighbor->parent = current;
                openSet.push(neighbor);
            }
        }
    }
    return std::vector<Node*>();  // No path found
}

std::vector<Node*> Astar::reconstructPath(Node* node) {
    std::vector<Node*> path;
    while (node) {
        path.push_back(node);
        node = node->parent;
    }
    std::reverse(path.begin(), path.end());
    return path;
}
