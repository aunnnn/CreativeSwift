//
//  Math.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/19/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

/// Normalizes a number from one range into another
public func map(value: CGFloat, fromLow: CGFloat, fromHigh: CGFloat, toLow: CGFloat, toHigh: CGFloat) -> CGFloat {
    let ratio = (value-fromLow) / (fromHigh-fromLow)
    return ratio * (toHigh-toLow) + toLow
}

/// Normalizes a number from another range into a value between 0 and 1
public func norm(value: CGFloat, low: CGFloat, high: CGFloat) -> CGFloat {
    return map(value: value, fromLow: low, fromHigh: high, toLow: 0, toHigh: 1)
}

/// - returns: Array of Ints from min to max.
public func range(min: Int, max: Int) -> [Int] {
    if max < min { return [] }
    return [Int](min...max)
}

public func rangef(min: CGFloat, max: CGFloat, step: CGFloat=1) -> [CGFloat] {
    let count = Int(floor((max - min) / step)) + 1
    var vals = [CGFloat].init(repeating: -1, count: count)
    var value = min
    for (i, _) in vals.enumerated() {
        vals[i] = value
        value += step
    }
    return vals
}

public func distsq(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) -> CGFloat {
    let dx = x2 - x1
    let dy = y2 - y1
    return dx * dx + dy * dy
}

public func distsq(p1: CGPoint, p2: CGPoint) -> CGFloat {
    return distsq(x1: p1.x, y1: p1.y, x2: p2.x, y2: p2.y)
}

public func dist(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) -> CGFloat {
    return sqrt(distsq(x1: x1, y1: y1, x2: x2, y2: y2))
}

public func dist(p1: CGPoint, p2: CGPoint) -> CGFloat {
    return sqrt(distsq(p1: p1, p2: p2))
}

/// Linear interpolation.
/// - Parameters:
///     - start: first value
///     - stop: second value
///     - amt: float between 0.0 and 1.0
public func lerp(start: CGFloat, stop: CGFloat, amt: CGFloat) -> CGFloat {
    return (1 - amt) * start + amt * stop
}

public func magsq(x: CGFloat, y: CGFloat) -> CGFloat {
    return distsq(x1: 0, y1: 0, x2: x, y2: y)
}

public func magsq(p: CGPoint) -> CGFloat {
    return magsq(x: p.x, y: p.y)
}

public func mag(x: CGFloat, y: CGFloat) -> CGFloat {
    return dist(x1: 0, y1: 0, x2: x, y2: y)
}

public func mag(p: CGPoint) -> CGFloat {
    return dist(x1: 0, y1: 0, x2: p.x, y2: p.y)
}

public func sum(_ numbers: [CGFloat]) -> CGFloat {
    return numbers.reduce(0, { (res, item) in
        return res + item
    })
}

public func sum(_ numbers: CGFloat...) -> CGFloat {
    return sum(numbers)
}

public func avg(_ numbers: [CGFloat]) -> CGFloat {
    if numbers.count == 0 { return 0 }
    return  sum(numbers)/numbers.count.asCGFloat
}

public func avg(_ numbers: CGFloat...) -> CGFloat {
    return avg(numbers)
}

public func avg(points: [CGPoint]) -> CGPoint {
    if points.count == 0 { return .zero }
    let total: (CGFloat, CGFloat) = points.reduce((0, 0), { (res: (CGFloat, CGFloat), item: CGPoint) -> (CGFloat, CGFloat) in
        return (res.0 + item.x, res.1 + item.y)
    })
    return CGPoint.init(x: total.0/points.count.asCGFloat, y: total.1/points.count.asCGFloat)
}

public func avg(points: CGPoint...) -> CGPoint {
    return avg(points: points)
}

public func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x/rhs, y: lhs.y/rhs)
}

public func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x*rhs, y: lhs.y*rhs)
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
}
