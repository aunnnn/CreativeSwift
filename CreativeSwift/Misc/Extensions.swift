//
//  Extensions.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/22/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

public extension UIColor{
    
    /// Color from rgb hex.
    convenience init(rgb: UInt, alphaVal: CGFloat=1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
    
    /// Color from hsb hex.
    convenience init(hsb: UInt, alphaVal: CGFloat=1.0) {
        self.init(
            hue: CGFloat((hsb & 0xFF0000) >> 16) / 255.0,
            saturation: CGFloat((hsb & 0x00FF00) >> 8) / 255.0,
            brightness: CGFloat(hsb & 0x0000FF) / 255.0,
            alpha: alphaVal)
    }
    
    /// RGB from UIColor.
    func rgb() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = fRed
            let iGreen = fGreen
            let iBlue = fBlue
            let iAlpha = fAlpha
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return (red:0, green:0, blue:0, alpha:1)
        }
    }
}

public extension CGRect {
    
    var originX: CGFloat {
        return self.origin.x
    }
    
    var originY: CGFloat {
        return self.origin.y
    }
    
    var center: CGPoint {
        return .init(x: midX, y: midY)
    }
    
    /// Make rect with center and size.
    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width/2, y: center.y - size.height/2, width: size.width, height: size.height)
    }
    
    /// Make rect with center and size.
    init(centerX: CGFloat, centerY: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: centerX - width/2, y: centerY - height/2, width: width, height: height)
    }
    
    /// Moved rect.
    func move(dx: CGFloat, dy: CGFloat) -> CGRect {
        return CGRect.init(x: originX + dx, y: originY + dy, width: self.width, height: self.height)
    }
}

public extension CGSize {
    
    var rectAtZero: CGRect {
        return CGRect.init(origin: .zero, size: self)
    }
}

public extension CGPoint {
    
    /// Get xy tuple.
    var xy: (CGFloat, CGFloat) {
        return (self.x, self.y)
    }
}

public extension Int {
    
    /// Cast Int to CGFloat for doing quick operation between Int and CGFloat.
    var asCGFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension Double {
    
    /// Cast Int to CGFloat for doing quick operation between Int and CGFloat.
    var asCGFloat: CGFloat {
        return CGFloat(self)
    }
}

// MARK: Radians and degrees
public extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
    var radiansToDegrees: CGFloat { return CGFloat(self) * 180 / .pi }
}

public extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
