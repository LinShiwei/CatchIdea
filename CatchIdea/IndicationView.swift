//
//  IndicationView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class IndicationView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    internal var active = false {
        didSet{
            active ? performActiveAction() : performInaciveAction()
        }
    }
    
    private var indicationLabel: UILabel
    
    
    override init(frame: CGRect){
        assert(frame.width > 199)
        assert(frame.height > 20)
        
        indicationLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 21)))
        indicationLabel.text = LocalizationStrings.shared.pullIndicationText
        indicationLabel.textColor = UIColor.lightGray
        indicationLabel.font = UIFont.systemFont(ofSize: 14)
        super.init(frame: frame)
        
        addSubview(indicationLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicationLabel.center = CGPoint(x: frame.width-indicationLabel.frame.width/2, y: frame.height-indicationLabel.frame.height/2)
    }
    
    private func performActiveAction(){
        indicationLabel.text = LocalizationStrings.shared.releaseIndicationText
        indicationLabel.textColor = Theme.shared.mainThemeColor
    }
    
    private func performInaciveAction(){
        indicationLabel.text = LocalizationStrings.shared.pullIndicationText
        indicationLabel.textColor = UIColor.lightGray
    }
}
