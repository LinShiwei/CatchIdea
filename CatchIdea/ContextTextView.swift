//
//  ContextTextView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class ContextTextView: UITextView {

    internal let placeholder = LocalizationStrings.shared.createIdeaContextViewPlaceholder
    
    internal var contentText: String {
        get{
            return text == placeholder ? "" : text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        text = placeholder
        textColor = UIColor.lightGray
    }
    
}
