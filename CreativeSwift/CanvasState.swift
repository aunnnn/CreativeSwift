//
//  CanvasState.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/19/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

/// Store useful canvas-specific states. Also available globally.
public class CanvasState {
    
    /// Time lapses in seconds.
    public var timeLapsed: Double = 0
    
    public var frameCount: Int = 0
    
    /// Latest touch location if applicable.
    public var touchLocation: CGPoint?
    
    /// Latest touch velocity if applicable (point/sec).
    public var touchVelocity: CGPoint?
    
    /// Whether receiving touch or not.
    public var isTouching: Bool = false
}

// MARK:- Computed Variables
public extension CanvasState {
    
    public var touchX: CGFloat? {
        return touchLocation?.x
    }
    
    public var touchY: CGFloat? {
        return touchLocation?.y
    }
}

/// Global Current State Convenient. Returns an active CanvasState.
public weak var GlobalCurrentState: CanvasState? = nil

/// Current state's time lapsed.
public var Seconds: Double {
    return GlobalCurrentState?.timeLapsed ?? 0
}

public var Milliseconds: Double {
    return Seconds * 1000
}

public var Minutes: Double {
    return Seconds / 60.0
}

public var Hours: Double {
    return Seconds / 3600.0
}


/// Current state's touchX.
public var TouchX: CGFloat? {
    return GlobalCurrentState?.touchX
}

/// Current state's touchY.
public var TouchY: CGFloat? {
    return GlobalCurrentState?.touchY
}

/// Current state's touch location.
public var TouchLocation: CGPoint? {
    return GlobalCurrentState?.touchLocation
}

/// Current state's touch velocity (point/sec).
public var TouchVelocity: CGPoint? {
    return GlobalCurrentState?.touchVelocity
}

/// Current state's frame count.
public var frameCount: Int {
    return GlobalCurrentState?.frameCount ?? 0
}

/// Is user touching the screen.
public var isTouching: Bool {
    return GlobalCurrentState?.isTouching ?? false
}

