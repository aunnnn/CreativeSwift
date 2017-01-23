//
//  Canvas.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/19/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

/// Interfaces for drawings on canvas. 
public protocol Canvas {
    
    /// Canvas width
    func width() -> CGFloat
    
    /// Canvas height
    func height() -> CGFloat
    
    /// Canvas size
    func size() -> CGSize
    
    /// Trigger re-drawing.
    func redraw()
    
    /// Set background color. Internally it fills rect at canvas' size.
    func background(color: UIColor)
    
    /// Set fill color. This will automatically enable fill.
    func fill(color: UIColor)
    
    /// Set stroke color. This will automatically enable stroke.
    func stroke(color: UIColor)
    
    /// Set stroke width.
    func strokeWidth(width: CGFloat)
    
    /// Set alpha for subsequent drawing.
    func alpha(alpha: CGFloat)
    
    func blendMode(mode: CGBlendMode)
    
    /// Disable fill for subsequent drawing. Call fill(color:) if you need fill again.
    func noFill()
    
    /// Disable stroke for subsequent drawing. Call stroke(color:) if you need stroke again.
    func noStroke()
    
    func point(point: CGPoint)
    func line(from: CGPoint, to: CGPoint)
    func rect(rect: CGRect)
    func ellipse(rect: CGRect)
    
    func point(x: CGFloat, y: CGFloat)
    func line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat)
    func rect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
    func ellipse(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
    
    /// Draw a custom shape.
    func shape(shapeBlock: (ShapeToolCreatable) -> Void)

    /// Draw text with current stroke color.
    func text(text: String, rect: CGRect)

    /// Draw image in rect.
    func image(image: UIImage, rect: CGRect)
    
    
    func translate(x: CGFloat, y: CGFloat)
    func rotate(theta: CGFloat)
    func scale(x: CGFloat, y: CGFloat)
    
    /// Draw while rotated around point p.
    func rotateBlock(theta: CGFloat, aroundPoint p: CGPoint, drawWhileRotated: (Canvas) -> Void)
    
    /// Styles in this block will not effect global styles. E.g., If you set fill, stroke, blendMode, translate, etc. It will not effect styles outside this block.
    func drawBlock(_ drawBlock: (Canvas) -> Void)
//    func get(x: CGFloat, y: CGFloat) -> UIColor
}

extension CanvasView: Canvas {
    
    func width() -> CGFloat {
        return self.frame.width
    }
    
    func height() -> CGFloat {
        return self.frame.height
    }
    
    func size() -> CGSize {
        return self.frame.size
    }
    
    func translate(x: CGFloat, y: CGFloat) {
        ctx?.translateBy(x: x, y: y)
    }
    
    func rotate(theta: CGFloat) {
        ctx?.rotate(by: theta)
    }
    
    func rotateBlock(theta: CGFloat, aroundPoint p: CGPoint, drawWhileRotated: (Canvas) -> Void) {
        guard let ctx = ctx else {
            fatalError("No context to draw text.")
        }
        UIGraphicsPushContext(ctx)
        
        ctx.translateBy(x: p.x, y: p.y)
        ctx.rotate(by: theta)
        ctx.translateBy(x: -p.x, y: -p.y)
        
        drawWhileRotated(self)
        
        UIGraphicsPopContext()
    }
    
    func scale(x: CGFloat, y: CGFloat) {
        ctx?.scaleBy(x: x, y: y)
        
    }
    
    func shape(shapeBlock: (ShapeToolCreatable) -> Void) {
        guard let ctx = ctx else {
            fatalError("No context to draw shapes.")
        }
        UIGraphicsPushContext(ctx)
        shapeBlock(ShapeTool())
        UIGraphicsPopContext()
    }
    
    func noFill() {
        self.sFill = false
    }
    
    func noStroke() {
        self.sStroke = false
    }
    
    func blendMode(mode: CGBlendMode) {
        ctx?.setBlendMode(mode)
    }
    
    func background(color: UIColor) {
        ctx?.saveGState()
        fill(color: color)
        rect(rect: self.bounds)
        ctx?.restoreGState()
    }
    
    func fill(color: UIColor) {
        self.sFill = true
        self.fillColor = color
        ctx?.setFillColor(color.cgColor)
    }
    
    func stroke(color: UIColor) {
        self.sStroke = true
        self.strokeColor = color
        ctx?.setStrokeColor(color.cgColor)
    }
    
    func strokeWidth(width: CGFloat) {
        ctx?.setLineWidth(width)
    }
    
    func alpha(alpha: CGFloat) {
        ctx?.setAlpha(alpha)
    }
    
    func point(point: CGPoint) {
        ctx?.beginPath()
        ctx?.move(to: point)
        ctx?.addRect(.init(x: point.x, y: point.y, width: 1, height: 1))
        drawPath()
    }
    
    func line(from: CGPoint, to: CGPoint) {
        ctx?.beginPath()
        ctx?.move(to: from)
        ctx?.addLine(to: to)
        drawPath()
    }
    
    func rect(rect: CGRect) {
        ctx?.beginPath()
        ctx?.addRect(rect)
        drawPath()
    }
    
    func ellipse(rect: CGRect) {
        ctx?.beginPath()
        ctx?.addEllipse(in: rect)
        drawPath()
    }
    
    func point(x: CGFloat, y: CGFloat) {
        self.point(point: .init(x: x, y: y))
    }
    
    func line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        self.line(from: .init(x: x1, y: y1) , to: .init(x: x2, y: y2))
    }
    
    func rect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.rect(rect: .init(x: x, y: y, width: width, height: height))
    }
    
    func ellipse(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.ellipse(rect: .init(x: x, y: y, width: width, height: height))
    }
    
    func text(text: String, rect: CGRect) {
        guard let ctx = ctx else {
            fatalError("No context to draw text.")
        }
        UIGraphicsPushContext(ctx)
        NSString(string: text).draw(in: rect, withAttributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 20),
            NSForegroundColorAttributeName: strokeColor
        ])
        UIGraphicsPopContext()
    }
    
    func image(image: UIImage, rect: CGRect) {
        guard let ctx = ctx else {
            fatalError("No context to draw image.")
        }
        UIGraphicsPushContext(ctx)
        image.draw(in: rect)
        UIGraphicsPopContext()
    }
    
    func drawBlock(_ drawBlock: (Canvas) -> Void) {
        ctx?.saveGState()
        drawBlock(self)
        ctx?.restoreGState()
    }
    
    func redraw() {
        self.layer.setNeedsDisplay()
        self.layer.displayIfNeeded()
    }
    
//    func get(x: CGFloat, y: CGFloat) -> UIColor {
//        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
//     
//       
//        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
//                                    green: CGFloat(pixel[1])/255.0,
//                                    blue: CGFloat(pixel[2])/255.0,
//                                    alpha: CGFloat(pixel[3])/255.0)
//        
//        pixel.deallocate(capacity: 4)
//        return .white
//    }
    
    private func drawPath() {
        if sFill && sStroke {
            ctx?.drawPath(using: .fillStroke)
        } else if sFill && !sStroke {
            ctx?.drawPath(using: .fill)
        } else if !sFill && sStroke {
            ctx?.drawPath(using: .stroke)
        } else {
            // Remember to call ctx.beginPath at start of new one to clear older path.
        }
    }
}
