// CUE knows how to resolve the following:
x: 200
x: y + 101
y: x - 101

// If a cycle is not broken, CUE will just report it.
a: b + 100
b: a - 100
