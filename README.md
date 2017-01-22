# CreativeSwift
Creative coding in Swift.

#### Quick Start
1. conforms to Sketchable. set FPS, Size, etc.
2. draw each frame in update(c: Canvas)
3. make CanvasViewController(sketchable: Sketchable)
4. done

#### Features
- Easy to use
- View Live result with Playground
- Grid helps you deal with abstracted coordinate
- Basic UIKit elements are included

#### Implementation Details
It might not be optimal, but this is how it's done internally:
- drawRect is called repeatedly by CADisplayLink (via setNeedDisplay())
- each draw is achieved by CGContext
- custom shape is achieved by UIBezierPath
