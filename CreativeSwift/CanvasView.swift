//
//  CanvasView.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/20/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

internal protocol CanvasViewDelegate: class {
    func draw()
}

/// View of CanvasViewController. It will handle all drawings with CGContext.
internal class CanvasView: UIView {
    
    internal var ctx: CGContext?    
    internal weak var delegate: CanvasViewDelegate?
    
    // MARK: Canvas
    internal var sFill: Bool = true
    internal var sStroke: Bool = true
    internal var fillColor: UIColor = .lightGray
    internal var strokeColor: UIColor = .black            
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        self.ctx = ctx
        
        // Perform drawing ...
        delegate?.draw()
    }
    
    override func draw(_ rect: CGRect) {
        // Should left empty here...
    }
}
