import PlaygroundSupport
import CreativeSwift


struct Global {
    static var c1: UIColor = .white
    static var bg: UIColor = .white
}

let oxford = loadImage(imageName: "oxford.jpeg")!

class Sketch: Sketchable {
    
    let grid: Grid
    var canvasSize = CGSize(width: 400, height: 400)
    
    var FPS: Int { return 60 }
    var PreferredSize: CGSize { return canvasSize }
    var ShouldStartOnViewDidAppear: Bool { return true }
    
    init() {
        self.grid = Grid(rows: 8, cols: 8, targetRect: .init(origin: .zero, size: canvasSize))
        self.grid.targetRectInset = .init(top: 22, left: 8, bottom: 8, right: 8)
    }
    
    func setup(p: Panel) {
        p.setFontSize(size: 22)
        p.setTextColor(color: .white)
        let lb = p.label(rect: grid.frame(startRow: 1, startCol: 1, endRow: 1, endCol: 6), text: "Creative Swift")
            
        p.switchview(origin: grid.origin(row: 2, col: 1)) { [unowned lb] (sw, cv, isOn) in
            Global.bg = isOn ? .green : .white
            lb.text = isOn ? "is so cool" : "Creative Swift"
            lb.textColor = isOn ? .green : .white
            
            p.label(rect: .init(origin: randomPoint(in: self.PreferredSize.rectAtZero), size: .init(width: 100, height: 44)), text: "Test")
        }
    }
    
    
    func update(c: Canvas, s: CanvasState) {
        c.background(color: Global.bg)
        
        c.drawBlock { (c) in
            c.stroke(color: UIColor.lightText)
            for block in grid.allBlocks() {
                c.rect(rect: block)
            }
        }
    }
    
    func touch(location: CGPoint, velocity: CGPoint) {
        print(location)
        Global.bg = .init(hue: location.x/PreferredSize.width, saturation: location.y/PreferredSize.height, brightness: 0.6, alpha: 1.0)
    }
    
    func viewSizeDidChanged(size: CGSize) {
        self.canvasSize = size
        self.grid.targetRect = .init(origin: .zero, size: size)
    }
}

let sk = Sketch()
let cv = CanvasViewController(sketchable: sk)
cv.view.frame = .init(origin: .zero, size: sk.PreferredSize)

Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
    cv.view.frame = .init(origin: .zero, size: sk.PreferredSize)
}.fire()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = cv.view
