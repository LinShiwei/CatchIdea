//
//  TopDecorationView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/2.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class TopDecorationView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.shared.mainThemeColor
    }
}
