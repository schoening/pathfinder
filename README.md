# Pathfinder
A simple pathfinding class for games; written in Crystal.


# How to use

```
require "./pathfinder.cr"

grid = [
  [1, 1, 1],
  [1, 1, 1],
  [1, 1, 1],
]

pf = Pathfinder.new grid

pf.start 0, 0
pf.dest 2, 2

result = pf.search

puts result # [{0, 0}, {0, 1}, {0, 2}, {1, 2}, {2, 2}]
```

## Supports optional diagonals
```
pf.allow_diagonals = true
```
