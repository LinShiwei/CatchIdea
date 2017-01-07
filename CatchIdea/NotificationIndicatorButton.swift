//
//  NotificationIndicatorButton.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class NotificationIndicatorButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private let buttonLength: CGFloat = 22
    private let shortLineLayer = CALayer()
    private let longLineLayer = CALayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = Theme.shared.mainThemeColor.cgColor
        layer.borderWidth = 2
        
        shortLineLayer.frame = CGRect(x: 0, y: 0, width: 6, height: 2)
        shortLineLayer.backgroundColor = layer.borderColor
        longLineLayer.frame = CGRect(x: 0, y: 0, width: 2, height: 8)
        longLineLayer.backgroundColor = layer.borderColor
        
        layer.addSublayer(shortLineLayer)
        layer.addSublayer(longLineLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/2
        
        shortLineLayer.frame.origin = CGPoint(x: frame.width/2-1, y: frame.height/2-1)
        longLineLayer.frame.origin = CGPoint(x: frame.width/2-1, y: 3)
        
    }
}
