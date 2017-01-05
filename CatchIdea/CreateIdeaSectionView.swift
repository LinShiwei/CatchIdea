//
//  CreateIdeaSectionView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class CreateIdeaSectionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    internal var sectionTitle: String = "" {
        didSet {
            titleLabel.text = sectionTitle
        }
    }
    
    private var titleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addSubview(titleLabel)
        backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 8, y: frame.height-8-21, width: 150, height: 21)
    }
}
