import PlaygroundSupport

//: # Test Drawing Code in Realtime

//: We have to use internal class (CanvasView) to test drawing code directly. So it is @testable.
@testable import CreativeSwift

//: Set canvas's size here.
let Size: CGSize = .init(width: 200, height: 200)
let image = loadImage(imageName: "oxford.jpeg")!
let grid = Grid(rows: 10, cols: 10, targetRect: Size.rectAtZero)

//: Drawing...
class Drawer: CanvasViewDelegate {
    func draw() {
        print("draw...\nView result at Assistant Editor -> Select (Timeline)\nOr, on eye symbol at the right side of this line:\n---> canvas.setNeedsDisplay()")
        let cv = canvas as Canvas
        
        // Set styles for subsequent drawing
        cv.fill(color: .red)
        cv.stroke(color: .green)
        cv.strokeWidth(width: 4)
        cv.blendMode(mode: .normal)
        cv.strokeWidth(width: 1)
        
        // Set background color, aka. draw rect at canvas size
        cv.background(color: .darkGray)
        
        // Fundamental drawings
        cv.point(x: 5, y: 5)
        cv.line(x1: 200, y1: 4, x2: 0, y2: 200)
        cv.rect(x: 100, y: 0, width: 20, height: 20)
        cv.ellipse(x: 50, y: 50, width: 100, height: 40)
        
        // Matrix operations
        cv.translate(x: 5, y: 5)
        cv.rotate(theta: 0)
        cv.scale(x: 1, y: 1)
        
        // Text
        cv.stroke(color: .red)
        cv.text(text: "CreativeSwift", rect: grid.row(2))
        
        // Image
        cv.image(image: image, rect: grid.frame(startRow: 4, startCol: 4, endRow: 6, endCol: 6))
        
        // Grid
        cv.noFill()
        cv.stroke(color: .lightText)
        for block in grid.allBlocks() {
            cv.rect(rect: block)
        }
    
        cv.stroke(color: .green)
        // Custom shape
        // 1. use shapeTool to create either open/closed shape
        // 2. draw with lineTo, quadCurveTo, curveTo, ...
        // *3. always call done after finish
        // 4. actually draw by stroke(), fill() or fillAndStroke() the drawn path.
        //
        // repeat 1. to create new shape.
        
        cv.shape { shapeTool in
            shapeTool
            .createOpenShapeAt(x: 0, y: 0)
            .lineTo(x: 20, y: 0)
            .lineTo(x: 47, y: 50)
            .quadCurveTo(x: 160, y: 160, cx: 200, cy: 100)
            .quadCurveTo(x: 40, y: 180, cx: 200, cy: 200)
            .done()
            .stroke()
        }

        // All styles in this block e.g. fill/stroke/etc will not effect outside. Its graphics context is push and pop here.
        cv.drawBlock { (c) in
            cv.fill(color: .blue)
            cv.stroke(color: .orange)
            cv.strokeWidth(width: 4)
            cv.ellipse(x: 50, y: 160, width: 40, height: 40)
        }
        
        cv.shape { (tool) in
            cv.stroke(color: .yellow)
            let shape = tool.createOpenShapeAt(x: 0, y: 60)
            for p in rangef(min: 0, max: Size.width, step: 2) {
                shape.lineTo(x: p, y: 60 + 5*noise1D(x: Int(p+10)))
            }
            shape.done().stroke()
        }
        
        cv.rotateBlock(theta: M_PI_2.asCGFloat, aroundPoint: .zero) { cv in
            cv.line(x1: 50, y1: 50, x2: 150, y2: 50)
        }
    }
}

//: Setup
let canvas = CanvasView(frame: .init(origin: .zero, size: Size))

//: We can access current CGContext inside draw()
let drawer = Drawer()
canvas.delegate = drawer

//: Force draw, click on the eye-symbol at the right side to preview.
canvas.setNeedsDisplay()

//: This allows us to view result directly at Assistant Editor -> dropdown, Select (Timeline)
//: Try Editor -> Execute playground if result is not showing
PlaygroundPage.current.liveView = canvas
