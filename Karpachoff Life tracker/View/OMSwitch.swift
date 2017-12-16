//
//  OMSwitch.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 15/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit

protocol OMSwitchDelegate {
    func omSwitchValueDidChange(_ omSwitch: OMSwitch)
}

@IBDesignable
class OMSwitch: UIView {
    
    var delegate: OMSwitchDelegate? = nil
    
    @IBInspectable var trackUnselectedColor:UIColor = UIColor.lightGray
    @IBInspectable var circleUnselectedColor:UIColor = UIColor.gray
    @IBInspectable var trackSelectedColor:UIColor = UIColor.lightGray
    @IBInspectable var circleSelectedColor:UIColor = UIColor.gray
    @IBInspectable var isOn:Bool = false
    
    var viewRect: CGRect!
    var circleFrame: CGRect!
    var circleLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        viewRect = rect
        
        // create track path
        let trackFrame = CGRect(x: rect.origin.x + rect.height / 8, y: rect.origin.y + 1.75, width: rect.width - rect.height / 2, height: rect.height - 7)
        let trackPath = UIBezierPath.init(roundedRect: trackFrame, cornerRadius: rect.height / 2)
        
        trackLayer.frame = trackFrame
        trackLayer.path = trackPath.cgPath
        trackLayer.fillColor = trackUnselectedColor.cgColor
        
        circleFrame = CGRect(x: 0, y: 0, width: rect.height, height: rect.height)
        let circlePath = UIBezierPath.init(ovalIn: circleFrame)
        
        // create a CAShape Layer
        circleLayer.frame = circleFrame
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = circleUnselectedColor.cgColor
        
        //Add the layer to your view's layer
        layer.addSublayer(trackLayer)
        layer.addSublayer(circleLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var newFrame = circleLayer.frame
        
        if !isOn {
            
            newFrame.origin.x = viewRect.width - circleFrame.width
            
            UIView.animate(withDuration: 0.3) {
                self.circleLayer.frame = newFrame
                self.circleLayer.fillColor = self.circleSelectedColor.cgColor
                self.trackLayer.fillColor = self.trackSelectedColor.cgColor
            }
            
        } else {
            
            newFrame.origin.x = 0
            
            UIView.animate(withDuration: 0.3) {
                self.circleLayer.frame = newFrame
                self.circleLayer.fillColor = self.circleUnselectedColor.cgColor
                self.trackLayer.fillColor = self.trackUnselectedColor.cgColor
            }
        }
        
        isOn = !isOn
        delegate?.omSwitchValueDidChange(self)
    }
}
