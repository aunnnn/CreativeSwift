//
//  PanelView.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/22/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

/// A view that maintains all UIKits created through Panel interface. It is overlaid on top of CanvasView.
internal class PanelView: UIView {
    
    internal weak var canvasView: CanvasView?
    
    internal var standardFont: UIFont = UIFont.systemFont(ofSize: 18)
    internal var standardTextColor: UIColor = UIColor.black
    
    internal var buttonActionsDictionary: [Int: (UIButton, Canvas) -> Void] = [:]
    internal var sliderActionsDictionary: [Int: (UISlider, Canvas, CGFloat) -> Void] = [:]
    internal var switchActionsDictionary: [Int: (UISwitch, Canvas, Bool) -> Void] = [:]
    
    internal func buttonTapped(target: UIButton) {
        guard let canvas = canvasView else { fatalError("No canvas for panel.") }
        buttonActionsDictionary[target.tag]?(target, canvas)
    }
    
    internal func sliderValueChanged(target: UISlider) {
        guard let canvas = canvasView else { fatalError("No canvas for panel.") }
        sliderActionsDictionary[target.tag]?(target, canvas, CGFloat(target.value))
    }
    
    internal func switchValueChanged(target: UISwitch) {
        guard let canvas = canvasView else { fatalError("No canvas for panel.") }
        switchActionsDictionary[target.tag]?(target, canvas, target.isOn)
    }
}
