//
//  OMCircle.swift
//  Karpachoff Life tracker
//
//  Created by Oleg Minkov on 23/12/2017.
//  Copyright © 2017 Oleg Minkov. All rights reserved.
//

import UIKit

@IBDesignable
class OMCircle: UIView {
    
    @IBInspectable var color:UIColor = UIColor.clear

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let newRect = CGRect(x: 3, y: 3, width: rect.width - 6, height: rect.height - 6)
        let circlePath = UIBezierPath.init(ovalIn: newRect)
        color.setStroke()
        circlePath.stroke()
    }
}
