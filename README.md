# CreativeSwift
Creative coding for iOS written in Swift.


## Quick Start
Only two things to get started: Sketchable and CanvasViewController.

### Steps
1. conforms to Sketchable
2. in setup(p: Panel) use Panel for UIKit
3. in draw(c: Canvas) use Canvas for drawing
4. use CanvasViewController(sketchable: Sketchable)

Use autocomplete to guide you, or checkout Playgrounds.


## Features
- Looks like Processing
- Coordinate abstraction with Grid
- UIKit elements are included
- View live result with Playground

## Sketch Preview with Playground

![](http://g.recordit.co/P5iPIcQJ9x.gif)

## Code Preview

````Swift
class MySketch: Sketchable {

    var FPS: Int { return 60 }
    var PreferredSize: CGSize { return canvasSize }
    var ShouldStartOnViewDidAppear: Bool { return true }

    // View did load, setup UIKit
    func setup(p: Panel) {

        // Global styling for UIKit
        p.setFontSize(size: 22)
        p.setTextColor(color: .white)

        // UILabel added. No need to call addSubview.
        let lb = p.label(rect: r, text: "Hello World")

        // UIButton added.
        p.button(rect: r, title: "Tap me") { (bttn) in
            // Button tapped
        }

        // UISwitch added.
        let sw = p.switchview(origin: .zero) { (sw, isOn) in
            // Switch value changed
        }

        // UISlider added.
        p.slider(rect: r) { (slider, value) in
            // Slider value changed
        }

        // Customize...
        lb.backgroundColor = .red
    }

    // Draw loop
    func draw(c: Canvas, s: CanvasState) {

        c.background(color: .white)
        c.fill(color: .blue)
        c.stroke(color: .black)
        c.strokeWidth(width: 2)

        // Matrix
        c.translate(x: 5, y: 5)
        c.rotate(theta: M_PI.asCGFloat)
        c.scale(x: 1.2, y: 1.2)

        // Basic Drawings
        c.point(x: 0, y: 2)
        c.line(x1: 0, y1: 5, x2: 100, y2: 5)
        c.rect(x: 0, y: 0, width: 50, height: 50)
        c.ellipse(x: 0, y: 0, width: 50, height: 50)

        c.drawBlock { (c) in
            // styles in drawBlock will not effect globally
            c.stroke(color: .lightText)
            c.fill(color: .black)
        }

        if isTouching {
            // user is touching

            let touchX = TouchX!
            let touchY = TouchY!
        }

        // Text
        c.text(text: "Hey!", rect: r)

        // Image
        c.image(image: img, rect: 1)

        // Useful
        let msec = Milliseconds
        let sec = Seconds
        let min = Minutes
        let hr = Hours

    }

    func touch(location: CGPoint, velocity: CGPoint) {
        // User did touch
    }

    func viewSizeDidChanged(size: CGSize) {
        // Canvas's view size is changed
    }
}
````

## Installation
Cocoapods in near future. Right now please open CreativeSwift.xcodeproj and build a framework yourself.

## Implementation Details
It might not be optimal, but this is how it's done internally:
- drawRect is called repeatedly by CADisplayLink (via setNeedDisplay())
- Each draw is achieved by CGContext
- Custom shape is achieved by UIBezierPath

## Why
- It has Playground to preview live result!
- I'm familiar with iOS. Who is familiar OSX please help me porting it.

## Caveats
- Lagged on real device, especially heavy drawing. The framework is initially created only for quick prototyping with Playground.

## TODOs
- Read image pixels
- Clipping path
- Gradient fill
- Perlin noise 1D and 2D (Current there's only noise1D picked from internet...)
- Audio and FFT
- *Support OSX (will change a lot of code and take some times...)

## Contribute

Anything is welcomed. Honestly, please help, especially porting to OSX. If you have anything to comment or contribute, e.g., code structure, better drawing implementation, perlin noise code, any optimizations, feel free to contact or open issues.

## Contact
email: aun.wirawit@gmail.com