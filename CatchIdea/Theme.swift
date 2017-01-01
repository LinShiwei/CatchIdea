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
        let saturation: CGFloat = 0.36
        let brightness: CGFloat = 0.95
        
        return [
            UIColor(hue: 0.15, saturation: saturation, brightness: brightness, alpha: 1),
            UIColor(hue: 0.03, saturation: saturation, brightness: brightness, alpha: 1),
            UIColor(hue: 0.86, saturation: saturation, brightness: brightness, alpha: 1),
            UIColor(hue: 0.79, saturation: saturation, brightness: brightness, alpha: 1),
            UIColor(hue: 0.65, saturation: saturation, brightness: brightness, alpha: 1),
            UIColor(hue: 0.54, saturation: saturation, brightness: brightness, alpha: 1)
        ]
    }()
}
