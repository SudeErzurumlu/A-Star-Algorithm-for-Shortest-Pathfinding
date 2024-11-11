#ifndef ASTAR_H
#define ASTAR_H

#include <vector>

struct Node {
    int x, y;
    double g_cost;
    double h_cost;
    Node* parent;

    Node(int x, int y, double g_cost, double h_cost);
    double f_cost() const;
};

class Astar {
public:
    Astar(int width, int height);
    ~Astar();
    std::vector<Node*> findPath(int startX, int startY, int goalX, int goalY);

private:
    int width, height;
    std::vector<std::vector<Node*>> grid;

    void initializeNode(int x, int y, double g_cost, double h_cost);
    double heuristic(int x1, int y1, int x2, int y2);
    bool isValid(int x, int y);
    std::vector<Node*> getNeighbors(Node* node);
    std::vector<Node*> reconstructPath(Node* node);
};

#endif // ASTAR_H
