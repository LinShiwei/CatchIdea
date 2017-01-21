//
//  IdeaItem.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/18.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

internal class IdeaItem {
    internal let header: String
    internal let markColor: UIColor
    internal let addingDate: Date
    
    internal init(header: String = "", markColor: UIColor = UIColor.white, addingDate: Date){
        self.header = header
        self.markColor = markColor
        self.addingDate = addingDate
    }
}
