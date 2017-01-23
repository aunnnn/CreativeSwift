//
//  CanvasViewController.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/19/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

/// Main view controller that manages drawing on screen.
public class CanvasViewController: UIViewController, CanvasViewDelegate {

    private var displayLink: CADisplayLink?
    private var sketchable: Sketchable
    fileprivate var state: CanvasState {
        didSet {
            GlobalCurrentState = state
        }
    }
    private var initialTime: Double?
    private var canvasView: CanvasView? {
        guard self.view != nil else { return nil }
        return self.view as? CanvasView
    }
    private var canvas: Canvas? {
        guard self.view != nil else { return nil }
        return self.view as? Canvas
    }
    private var panel: Panel?
    private var canvasSize: CGSize {
        guard let view = self.viewIfLoaded else { return .zero }
        if sketchable.PreferredSize == .zero { return view.bounds.size }
        return sketchable.PreferredSize
    }
    
    public init(sketchable: Sketchable) {
        self.sketchable = sketchable
        state = CanvasState()        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Please use init(sketchable: Sketchable)")
    }
    
    public override func loadView() {
        let view = CanvasView()
        self.view = view
        self.view.frame = CGRect(origin: .zero, size: canvasSize)
        
        if sketchable.PreferredSize == .zero {
            self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.didPan(g:)))
        self.view.addGestureRecognizer(pan)
        
        let panel = PanelView()
        self.panel = panel
        panel.canvasView = view
        panel.backgroundColor = UIColor.clear
        panel.frame = self.view.frame
        panel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(panel)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.frame = CGRect(origin: .zero, size: canvasSize)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if sketchable.ShouldStartOnViewDidAppear {            
            start()
        }
    }
    
    internal func update() {
        if let timestamp = displayLink?.timestamp {
            let initialTime = self.initialTime ?? timestamp
            self.initialTime = initialTime
                        
            state.timeLapsed = timestamp - initialTime
        }
        
        state.frameCount += 1

        self.view.layer.setNeedsDisplay()
        self.view.layer.displayIfNeeded()
    }
    
    func draw() {
        guard let canvas = self.canvas else {
            fatalError("View should be Canvas.")
        }
        sketchable.draw(c: canvas, s: state)
    }
    
    // MARK:- Interfaces
    
    /// Stop and remove runloop.
    public func stop() {
        displayLink?.invalidate()
    }
    
    /// Start (or restart) update loop. This will also reset the state.
    public func start() {
        
        // force load view if needed
        _ = self.view
        initialTime = nil
        state = CanvasState()
        
        guard canvas != nil else {
            return
        }
        
        guard let panel = panel else {
            return
        }
        
        sketchable.setup(p: panel)
        self.canvasView?.delegate = self
        
        // start
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(self.update))
        let acceptableFPS = min(max(sketchable.FPS, 1),60)
        
        if #available(iOS 10.0, *) {
            displayLink?.preferredFramesPerSecond = acceptableFPS
        } else {
            // Fallback on earlier versions
            displayLink?.frameInterval = 60/acceptableFPS
        }
        displayLink?.add(to: .main, forMode: .defaultRunLoopMode)
    }
    
    func didPan(g: UIPanGestureRecognizer) {
        let location = g.location(in: self.view)
        let velocity = g.velocity(in: self.view)
        switch g.state {
        case .began, .changed:
            state.isTouching = true
            state.touchLocation = location
            state.touchVelocity = velocity
            sketchable.touch(location: location, velocity: velocity)
        case .ended:
            state.isTouching = false
            state.touchLocation = location
            state.touchVelocity = velocity
            sketchable.touch(location: location, velocity: velocity)
        default: break
        }
    }

    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        sketchable.viewSizeDidChanged(size: size)
    }
}
