//
//  Utilities.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/21/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

public var ScreenSize: CGSize {
    return UIScreen.main.bounds.size
}

// MARK:- Values

/// Get random color.
public func randomColor(alpha: CGFloat=1) -> UIColor {
    return UIColor.init(red: random(), green: random(), blue: random(), alpha: alpha)
}

/// Linear interpolation between pair of colors
public func lerpColor(from: UIColor, to: UIColor, amt: CGFloat) -> UIColor {
    let comps1 = from.rgb()
    let comps2 = to.rgb()
    let r = lerp(start: comps1.red, stop: comps2.red, amt: amt)
    let g = lerp(start: comps1.green, stop: comps2.green, amt: amt)
    let b = lerp(start: comps1.blue, stop: comps2.blue, amt: amt)
    let a = lerp(start: comps1.alpha, stop: comps2.alpha, amt: amt)
    return UIColor.init(red: r, green: g, blue: b, alpha: a)
    
}

/// Random number between 0 and 1.
public func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

/// Random number between min and max inclusive.
public func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max-min) + min
}

/// Random point inside rect.
public func randomPoint(in rect: CGRect) -> CGPoint {
    return CGPoint.init(x: random(min: rect.originX, max: rect.maxX), y: random(min: rect.originY, max: rect.maxY))
}

public var noise1DSeed: Int = 1

/// Perlin Noise 1D? This is taken from internet.
public func noise1D(x : Int) -> CGFloat {
    var x = x
    x = (x >> 13) ^ x;
    x = (x &* (x &* x &* noise1DSeed &+ 19990303) &+ 1376312589) & 0x7fffffff
    let inner = (x &* (x &* x &* 15731 &+ 789221) &+ 1376312589) & 0x7fffffff
    return (1.0 - ( CGFloat(inner) ) / 1073741824.0)
}
