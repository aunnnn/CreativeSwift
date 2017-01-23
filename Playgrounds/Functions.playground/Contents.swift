//: Playground - noun: a place where people can play

import CreativeSwift
import PlaygroundSupport

//: # Maths
let p1 = CGPoint(x: 4, y: 5)
let p2 = CGPoint(x: 60, y: 20)

//: General
sum(1, 2, 4, 5)
sum([1,2,3,4])

avg(1,2,3,4)
avg([1,2,3,4])
avg(points: [p1, p2])
avg(points: p1, p2)

map(value: 20, fromLow: 10, fromHigh: 30, toLow: 0, toHigh: 5)
lerp(start: 12, stop: 20, amt: 0.5)
norm(value: 20, low: 0, high: 100)

dist(p1: p1, p2: p2)
dist(x1: 0, y1: 0, x2: 3, y2: 4)

distsq(p1: p1, p2: p2)
distsq(x1: p1.x, y1: p1.y, x2: p2.x, y2: p2.y)
mag(p: p1)

//: # Utilities
randomColor()
random()
random(min: 20, max: 30)
//: Range
range(min: 0, max: 5)
rangef(min: 1, max: 4, step: 0.25)

let c1: UIColor = .red
let c2: UIColor = .green
//: Color interpolation
lerpColor(from: c1, to: c2, amt: 0.0)
lerpColor(from: c1, to: c2, amt: 0.25)
lerpColor(from: c1, to: c2, amt: 0.5)
lerpColor(from: c1, to: c2, amt: 0.75)
lerpColor(from: c1, to: c2, amt: 1.0)

//: # Read file
//: Text
let lines = loadStrings(filename: "s1.txt", separatedBy: .newlines)
let isSeparatedStrings = loadStrings(filename: "s1.txt", separatedBy: .string(s: "is"))
let commaSeparatedStrings = loadStrings(filename: "s2.txt", separatedBy: .commas)
let raw = loadString(filename: "s1.txt")

//: Image
let image = loadImage(imageName: "oxford.jpeg")

//: File Path
filePath(for: "oxford.jpeg", type: nil)
filePath(for: "oxford", type: "jpeg")
fileUrl(for: "oxford.jpeg", type: nil)
fileUrl(for: "oxford", type: "jpeg")

//: # Grid
//: A convenient class to manage coordinates. Can be a simple Autolayout for Canvas.

let grid = Grid(rows: 8, cols: 10, targetRect: .init(x: 0, y: 0, width: 200, height: 500))

//: Apply inset on the grid.
grid.targetRectInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)

//: Rect can be changed later.
grid.targetRect = .init(x: 0, y: 0, width: 200, height: 400)

grid.blockSize
grid.block(row: 4, col: 6)
grid.frame(startRow: 0, startCol: 0, endRow: 4, endCol: 5)
grid.origin(row: 4, col: 6)
grid.row(4)
grid.col(6)


//: In case you want all blocks. E.g., to draw grid.
for block in grid.allBlocks() {
    // do something with block (CGRect)...
}

//: # Conveniences

p1 / 4
p1 * 4
p1 + p2

let (p1X, p1Y) = p1.xy

5.asCGFloat
M_PI.radiansToDegrees
180.degreesToRadians

//: Rect
// Rect with center
let r1 = CGRect.init(center: .zero, size: CGSize.init(width: 50, height: 50))
let r2 = CGRect.init(centerX: 5, centerY: 6, width: 50, height: 50)

r1.originX
r1.originY
r1.center


// Rect from size at origin .zero
let r3 = CGSize.init(width: 50, height: 50).rectAtZero

//: Color
let color1 = UIColor.init(rgb: 0xFF0123)
let color2 = UIColor.init(hsb: 0xA401FF)

color1.rgb()


