//
//  addingIconView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class AddingIconView: UIView {
    
    internal var active = false {
        didSet{
            active ? performActiveAnimation() : performInactiveAnimation()
        }
    }
    private let transverseLineLayer = CALayer()
    private let verticalLineLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        assert(frame.width == frame.height)
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        
        transverseLineLayer.frame = CGRect(x: frame.width/4, y: frame.height/2-1, width: frame.width/2, height: 2)
        transverseLineLayer.backgroundColor = layer.borderColor
        
        verticalLineLayer.frame = CGRect(x: frame.width/2-1, y: frame.height/4, width: 2, height: frame.height/2)
        verticalLineLayer.backgroundColor = layer.borderColor
        
        layer.addSublayer(transverseLineLayer)
        layer.addSublayer(verticalLineLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func performActiveAnimation(){
        self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI-0.0000001))
        self.layer.borderColor = Theme.shared.mainThemeColor.cgColor
        transverseLineLayer.backgroundColor = layer.borderColor
        verticalLineLayer.backgroundColor = layer.borderColor
    }
    
    private func performInactiveAnimation(){
        self.transform = .identity
        self.layer.borderColor = UIColor.lightGray.cgColor
        transverseLineLayer.backgroundColor = layer.borderColor
        verticalLineLayer.backgroundColor = layer.borderColor
    }
    
    
}
