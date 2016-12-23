//
//  GeneralControlButton.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class GeneralControlButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        layer.backgroundColor = Theme.shared.generalControlButtonBackgroundColor.cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/2
    }
}
