import PlaygroundSupport
import CreativeSwift

PlaygroundPage.current.needsIndefiniteExecution = true

struct Global {
    static var c1: UIColor = .white
    static var bg: UIColor = .lightGray
    static var freq1: CGFloat = 2
}

let oxford = loadImage(imageName: "oxford.jpeg")!
var canvasSize = CGSize(width: 400, height: 400)

// Laying out things easily
let grid = Grid(rows: 8, cols: 8, targetRect: .init(origin: .zero, size: canvasSize))

class Sketch: Sketchable {
    
    let grid: Grid
    
    var FPS: Int { return 60 }
    var PreferredSize: CGSize { return canvasSize }
    var ShouldStartOnViewDidAppear: Bool { return true }
    
    init() {
        self.grid = Grid(rows: 8, cols: 8, targetRect: .init(origin: .zero, size: canvasSize))
        self.grid.targetRectInset = .init(top: 22, left: 8, bottom: 8, right: 8)
    }
    
    // View did load, setup UIKit, prepare things
    func setup(p: Panel) {
        print("draw...\(random())")
        
        // Global styling for UIKit
        p.setFontSize(size: 22)
        p.setTextColor(color: .white)
        
        // UILabels
        
        let lb1 = p.label(rect: grid.row(0), text: "CreativeSwift Is so cool!.")
        lb1.font = UIFont.boldSystemFont(ofSize: 22)
        lb1.textColor = UIColor.lightText
        
        p.label(rect: grid.row(1, startCol: 2), text: "Toggle to show button.")
        p.label(rect: grid.row(4).offsetBy(dx: 4, dy: 0), text: "Slide to change background color")
        
        // UIButton
        let bttn = p.button(rect: grid.row(2), title: "Tap for random color") { (bttn) in
            // Button tapped
            bttn.backgroundColor = randomColor().withAlphaComponent(0.6)
        }
        
        // UISwitch
        let sw = p.switchview(origin: grid.row(1).origin.move(dx: 4, dy: 8)) { [unowned bttn] (sw, isOn) in
            // Switch value changed
            bttn.isHidden = !isOn
        }
        
        // UISlider
        let sliderFrame = grid.row(3, startCol: 2, endCol: 5)
        p.slider(rect: sliderFrame) { (slider, value) in
            // Slider value changed
            Global.bg = lerpColor(from: .red, to: .blue, amt: value)
        }
        
        // You can customize...
        sw.tintColor = .white
        bttn.isHidden = true
        bttn.backgroundColor = .lightText
        bttn.titleColor = .white
    }
    
    // Drawing in FPS
    // Canvas is for drawing, s is general state info like isTouching, touchLocation.
    // ** s is also available globally.
    func draw(c: Canvas, s: CanvasState) {
        c.background(color: Global.bg)
        
        // Draw grid
        c.drawBlock { (c) in
            // styles in drawBlock will not effect globally
            
            c.stroke(color: .lightText)
            c.fill(color: .black)
            for block in grid.allBlocks() {
                c.rect(rect: block)
            }
        }
        
        // or s.isTouching
        if isTouching {
            let touch = TouchLocation! // or s.touchLocation
            c.fill(color: randomColor())
            c.stroke(color: .yellow)
            c.rect(rect: touch.centerOfRect(with: CGSize.init(width: 20, height: 20)))
            
            Global.freq1 = lerp(start: 2, stop: 8, amt: 1 - TouchY!/PreferredSize.height)
        }
        
        // Text
        let dx = 12 * sin(Seconds).asCGFloat
        c.text(text: "Moving...", rect: grid.row(6, startCol: 1).offsetBy(dx: dx, dy: 0))
        
        // Image
        c.image(image: oxford, rect: grid.block(row: 6, col: 6))
        
        c.drawBlock { (c) in
            c.strokeWidth(width: 2)
            // Seconds, Milliseconds, Minutes, Hours are available globally.
            // Or s.timeLapsed and compute it yourself.
            let t = (Seconds * (M_PI)).asCGFloat
            
            // Make range of float.
            for x in rangef(min: 0, max: PreferredSize.width, step: 8) {
                // White wave y
                let y1 = PreferredSize.height - 20 * sin(2 * M_PI.asCGFloat * x/PreferredSize.width + t) - 40
                
                // Red wave y
                let y2 = PreferredSize.height - 10 * sin(Global.freq1 * M_PI.asCGFloat * x/PreferredSize.width - 2*t) - 20
                
                c.stroke(color: .white)
                c.line(x1: x, y1: PreferredSize.height, x2: x, y2: y1)
                c.stroke(color: .red)
                c.line(x1: x + 4, y1: PreferredSize.height, x2: x + 4, y2: y2)
            }
        }
    }
    
    func touch(location: CGPoint, velocity: CGPoint) {
        // User did touch
    }
    
    func viewSizeDidChanged(size: CGSize) {
        // Canvas's view size is changed
    }
}

let sk = Sketch()
let cv = CanvasViewController(sketchable: sk)
cv.view.frame = .init(origin: .zero, size: sk.PreferredSize)

// Live result. If doesn't show, try close Xcode and reopen.
PlaygroundPage.current.liveView = cv.view
