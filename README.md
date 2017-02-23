# Pathfinder
A simple pathfinding class for games; written in Crystal.


# How to use

```
require "./pathfinder.cr"

# 0 = wall
# 1 = walkable
grid = [
  [1, 1, 1],
  [1, 0, 0],
  [1, 1, 1],
]

pf = Pathfinder.new grid

pf.start 0, 0
pf.dest 2, 2

result = pf.search

puts result # [{1, 0}, {2, 0}, {2, 1}, {2, 2}]
```

## Supports optional diagonals (WIP)
Diagonals still need some work, try them out by enabling them:
```
pf.allow_diagonals = true
```

## Accessing/modifying the grid
The pathfinder creates a grid internally, so to update it dynamically (a creature could be blocking some area occasionally) ypu need to change the the grid like so:
```
pf.graph.grid[0][0] = 0 # set to wall
```
