//
//  Panel.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/19/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

/// Interfaces for UIKits. Available only at setup.
public protocol Panel {
    
    func setStandardFont(font: UIFont)
    func setFontSize(size: CGFloat)
    func setTextColor(color: UIColor)
    
    @discardableResult func label(rect: CGRect, text: String) -> UILabel
    @discardableResult func imageview(rect: CGRect, image: UIImage) -> UIImageView
    @discardableResult func textfield(rect: CGRect, placeholder: String) -> UITextField
    @discardableResult func button(rect: CGRect, title: String, action: @escaping (UIButton, Canvas) -> Void) -> UIButton
    @discardableResult func switchview(origin: CGPoint, action: @escaping (UISwitch, Canvas, Bool) -> Void) -> UISwitch
    @discardableResult func slider(rect: CGRect, action: @escaping (UISlider, Canvas, CGFloat) -> Void) -> UISlider
    
    /// Clear all elements on Panel.
    func reset()
}

extension PanelView: Panel {

    func setStandardFont(font: UIFont) {
        self.standardFont = font
    }
    
    func setFontSize(size: CGFloat) {
        self.standardFont = standardFont.withSize(size)
    }
    
    func setTextColor(color: UIColor) {
        self.standardTextColor = color
    }
    
    func label(rect: CGRect, text: String) -> UILabel {
        let label = UILabel(frame: rect)
        label.text = text
        label.font = standardFont
        label.textColor = standardTextColor
        label.textAlignment = .left
        label.frame = rect
        self.addSubview(label)
        
        return label
    }
    
    func imageview(rect: CGRect, image: UIImage) -> UIImageView {
        let imageview = UIImageView(image: image)
        imageview.frame = rect
        imageview.contentMode = .scaleAspectFit
        self.addSubview(imageview)
        return imageview
    }
    
    func textfield(rect: CGRect, placeholder: String) -> UITextField {
        let textField = UITextField(frame: rect)
        textField.placeholder = placeholder
        textField.font = standardFont
        textField.textColor = standardTextColor
        self.addSubview(textField)
        return textField
    }
    
    func button(rect: CGRect, title: String, action: @escaping (UIButton, Canvas) -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.frame = rect
        button.setTitle(title, for: .normal)
        button.setTitleColor(standardTextColor, for: .normal)
        button.titleLabel?.font = standardFont
        button.tag = buttonActionsDictionary.count
        button.addTarget(self, action: #selector(self.buttonTapped(target:)), for: .touchUpInside)
        self.addSubview(button)
        
        buttonActionsDictionary[button.tag] = action
        return button
    }
    
    func switchview(origin: CGPoint, action: @escaping (UISwitch, Canvas, Bool) -> Void) -> UISwitch {
        let switchView = UISwitch()
        switchView.frame = .init(origin: origin, size: .zero)
        switchView.addTarget(self, action: #selector(self.switchValueChanged(target:)), for: .valueChanged)
        switchView.tag = switchActionsDictionary.count
        self.addSubview(switchView)
        
        switchActionsDictionary[switchView.tag] = action
        return switchView
    }
    
    func slider(rect: CGRect, action: @escaping (UISlider, Canvas, CGFloat) -> Void) -> UISlider {
        let slider = UISlider()
        slider.frame = rect
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(self.sliderValueChanged(target:)), for: .valueChanged)
        self.addSubview(slider)
        
        sliderActionsDictionary[slider.tag] = action
        return slider
    }
    
    func reset() {
        for sv in self.subviews {
            sv.removeFromSuperview()
        }
        
        self.buttonActionsDictionary = [:]
        self.sliderActionsDictionary = [:]
    }
}
