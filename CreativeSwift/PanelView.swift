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
    
    internal var buttonActionsDictionary: [Int: (UIButton) -> Void] = [:]
    internal var sliderActionsDictionary: [Int: (UISlider, CGFloat) -> Void] = [:]
    internal var switchActionsDictionary: [Int: (UISwitch, Bool) -> Void] = [:]
    
    internal func buttonTapped(target: UIButton) {
        buttonActionsDictionary[target.tag]?(target)
    }
    
    internal func sliderValueChanged(target: UISlider) {
        sliderActionsDictionary[target.tag]?(target, CGFloat(target.value))
    }
    
    internal func switchValueChanged(target: UISwitch) {
        switchActionsDictionary[target.tag]?(target, target.isOn)
    }
}
