//
//  ShapeTool.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/22/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

/* 
 
 Concept: Shape Drawing = Creatable --> Drawable --> Finishable
 
 Creatable = start shape, create UIBezierPath
 Drawable = add line, curve, arc, quad, ...
 Finishable = fill, stroke, fill and stroke
 
*/

/// A type that can create Shape.
public protocol ShapeToolCreatable {
    
    /// Start closed shape at p.
    func createClosedShape(at p: CGPoint) -> ShapeToolDrawable
    func createClosedShapeAt(x: CGFloat, y: CGFloat) -> ShapeToolDrawable
    
    /// Start open shape at p.
    func createOpenShape(at p: CGPoint) -> ShapeToolDrawable
    func createOpenShapeAt(x: CGFloat, y: CGFloat) -> ShapeToolDrawable
}

/// A type that can draw Shape. Always call done() at the end.
public protocol ShapeToolDrawable {
    
    func line(to p: CGPoint) -> ShapeToolDrawable
    func curve(to p: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> ShapeToolDrawable
    func quadCurve(to p: CGPoint, controlPoint: CGPoint) -> ShapeToolDrawable
    
    // MARK: Conveniences
    func lineTo(x: CGFloat, y: CGFloat) -> ShapeToolDrawable
    func arc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> ShapeToolDrawable
    func curveTo(x: CGFloat, y: CGFloat, cx1: CGFloat, cy1: CGFloat, cx2: CGFloat, cy2: CGFloat) -> ShapeToolDrawable
    func quadCurveTo(x: CGFloat, y: CGFloat, cx: CGFloat, cy: CGFloat) -> ShapeToolDrawable
    
    /// Call this when done drawing.
    func done() -> ShapeToolFinishable
}

/// A type that can finish Shape drawing with fill, stroke or both.
public protocol ShapeToolFinishable {
    
    /// Fill created shape.
    ///
    /// **Note that opened shape is closed automatically if you call this.**
    func fill()
    
    /// Fill and stroke created shape.
    ///
    /// **Note that opened shape is closed automatically if you call this.**
    func fillAndStroke()
    
    func stroke()
    func finish(fill: Bool, andThenStroke stroke: Bool)
}


/// A tool to begin new shape on given UIBezierPath.
/// Checkout [How to draw with UIBezierPath.](https://developer.apple.com/library/content/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/BezierPaths/BezierPaths.html)
internal struct ShapeCanvas {
    fileprivate let path = UIBezierPath()
    fileprivate let isClosedShape: Bool
    
    fileprivate init(closed: Bool) {
        self.isClosedShape = closed
    }
}

/// Starting point, it creates Canvas and hands off ShapeToolCreatable
internal struct ShapeTool {}

extension ShapeTool: ShapeToolCreatable {
    
    public func createClosedShape(at p: CGPoint) -> ShapeToolDrawable {
        let tool = ShapeCanvas(closed: true)
        tool.path.move(to: p)
        return tool
    }
    
    public func createClosedShapeAt(x: CGFloat, y: CGFloat) -> ShapeToolDrawable {
        return createClosedShape(at: .init(x: x, y: y))
    }
    
    public func createOpenShape(at p: CGPoint) -> ShapeToolDrawable {
        let tool = ShapeCanvas(closed: false)
        tool.path.move(to: p)
        return tool
    }
    
    public func createOpenShapeAt(x: CGFloat, y: CGFloat) -> ShapeToolDrawable {
        return createOpenShape(at: .init(x: x, y: y))
    }
}

extension ShapeCanvas: ShapeToolDrawable {

    public func line(to p: CGPoint) -> ShapeToolDrawable {
        path.addLine(to: p)
        return self
    }
    
    public func curve(to p: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> ShapeToolDrawable {
        path.addCurve(to: p, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return self
    }
    
    public func arc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> ShapeToolDrawable {
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return self
    }
    
    public func quadCurve(to p: CGPoint, controlPoint: CGPoint) -> ShapeToolDrawable {
        path.addQuadCurve(to: p, controlPoint: controlPoint)
        return self
    }
    
    // MARK: Conveniences
    
    public func lineTo(x: CGFloat, y: CGFloat) -> ShapeToolDrawable {
        path.addLine(to: .init(x: x, y: y))
        return self
    }
    
    public func curveTo(x: CGFloat, y: CGFloat, cx1: CGFloat, cy1: CGFloat, cx2: CGFloat, cy2: CGFloat) -> ShapeToolDrawable {
        path.addCurve(to: .init(x: x, y: y), controlPoint1: .init(x: cx1, y: cy1), controlPoint2: .init(x: cx2, y: cy2))
        return self
    }
    
    public func quadCurveTo(x: CGFloat, y: CGFloat, cx: CGFloat, cy: CGFloat) -> ShapeToolDrawable {
        path.addQuadCurve(to: .init(x: x, y: y), controlPoint: .init(x: cx, y: cy))
        return self
    }

    public func done() -> ShapeToolFinishable {
        if isClosedShape {
            path.close()
        }
        return self
    }
}

extension ShapeCanvas: ShapeToolFinishable {
    public func fill() {
        path.fill()
    }
    
    public func stroke() {
        path.stroke()
    }
    
    public func fillAndStroke() {
        path.fill()
        path.stroke()
    }
    
    public func finish(fill: Bool, andThenStroke stroke: Bool) {
        if fill { path.fill() }
        if stroke { path.stroke() }
    }
}
