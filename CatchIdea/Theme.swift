//
//  Theme.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class Theme {
    static let shared = Theme()
    private init(){}
    
    internal let mainThemeColor = UIColor(red: 0, green: 0.73, blue: 0.42, alpha: 1)
    internal let mainThemeColorLight = UIColor(red: 0.18, green: 0.83, blue: 0.45, alpha: 1)
    
    internal let mainTextColor = UIColor.white
    internal let contentTextColor = UIColor.black
    
    internal let mainVCCellSwipeLeftColor = UIColor(red: 0.87, green: 0.24, blue: 0.054, alpha: 1)
    internal let mainVCCellSwipeRightColor = UIColor(red: 0.87, green: 0.24, blue: 0.054, alpha: 1)
    
    internal let trashVCCellSwipeLeftColor = UIColor(red: 0.87, green: 0.24, blue: 0.054, alpha: 1)
    internal let trashVCCellSwipeRightColor = UIColor(red: 0.357, green: 0.863, blue: 0.345, alpha: 1)
    
    internal let tableViewCellBackgroundColor = UIColor(white: 0.9, alpha: 1)
    internal let generalControlButtonBackgroundColor = UIColor.red
    
    internal let markColors : [UIColor] = {
        
        return [
            UIColor(red: 0.95, green: 0.82, blue: 0.23, alpha: 1),
            UIColor(red: 0.96, green: 0.55, blue: 0.15, alpha: 1),
            UIColor(red: 1, green: 0.1, blue: 0.06, alpha: 1),
            UIColor(red: 1, green: 0.27, blue: 0.69, alpha: 1),
            UIColor(red: 0.71, green: 0.35, blue: 0.89, alpha: 1),
            UIColor(red: 0.29, green: 0.32, blue: 0.92, alpha: 1)
        ]
    }()
}
