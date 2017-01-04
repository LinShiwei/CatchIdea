//
//  RefreshContainerView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class RefreshContainerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    internal var active = false {
        didSet{
            addingIcon.active = active
            indicationView.active = active
        }
    }
    
    private var addingIcon: AddingIconView
    private var indicationView: IndicationView
    
    override init(frame: CGRect){
        
        self.addingIcon = AddingIconView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.indicationView = IndicationView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            
        super.init(frame: frame)

        self.addSubview(addingIcon)
        self.addSubview(indicationView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addingIcon.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        indicationView.center = CGPoint(x: indicationView.frame.width/2, y: frame.height-indicationView.frame.height/2)
    }
}
