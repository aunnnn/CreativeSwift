//
//  Sketchable.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/19/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

/// Main interface for a Sketch. Conforms to this and start drawing!
public protocol Sketchable {
    
    /// Update rate in FPS.
    var FPS: Int { get }
    
    /// Preferred size of a canvas. If .zero, it will be screen size.
    var PreferredSize: CGSize { get }
    
    /// A value that tells if this sketch should start running on viewDidAppear.
    /// Default is true.
    ///
    /// If set to false, You must manually call .start() on CanvasViewController that manages this sketch.
    var ShouldStartOnViewDidAppear: Bool { get }
    
    /// View is already loaded.
    /// - Parameter p: Panel to setup UIKits easily.
    func setup(p: Panel)
    
    /// This function will be called repeatedly according to FPS provided.
    /// - Parameter c: Canvas to paint.
    /// - Parameter p: Panel to setup UIKits easily.
    func update(c: Canvas, s: CanvasState)
    
    /// Did receive touch event. location is the same as in CanvasState provded in update(:state).
    func touch(location: CGPoint, velocity: CGPoint)
    
    /// Size of the view controller that manages Canvas is changed. E.g., device orientation is changed.
    func viewSizeDidChanged(size: CGSize)
}

public extension Sketchable {
    
    var PreferredCanvasFrame: CGRect {
        return CGRect.init(origin: .zero, size: self.PreferredSize)
    }
}
