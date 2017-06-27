//
//  Theme.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
    typealias Color = UIColor
    
#else
#if os(macOS)
    import Cocoa
    typealias Color = NSColor
#endif
    //fatal error
    
#endif

internal class Theme {
    static let shared = Theme()
    private init(){}
    
    internal let mainThemeColor = Color(red: 0, green: 0.73, blue: 0.42, alpha: 1)
    internal let mainThemeColorLight = Color(red: 0.18, green: 0.83, blue: 0.45, alpha: 1)
    
    internal let mainTextColor = Color.white
    internal let contentTextColor = Color.black
    
    internal let mainVCCellSwipeLeftColor = Color(red: 0.87, green: 0.24, blue: 0.054, alpha: 1)
    internal let mainVCCellSwipeRightColor = Color(red: 0.87, green: 0.24, blue: 0.054, alpha: 1)
    
    internal let trashVCCellSwipeLeftColor = Color(red: 0.87, green: 0.24, blue: 0.054, alpha: 1)
    internal let trashVCCellSwipeRightColor = Color(red: 0.357, green: 0.863, blue: 0.345, alpha: 1)
    
    internal let tableViewCellBackgroundColor = Color(white: 0.9, alpha: 1)
    internal let generalControlButtonBackgroundColor = Color.red
    
    internal let markColors : [Color] = {
        
        return [
            Color(red: 0.95, green: 0.82, blue: 0.23, alpha: 1),
            Color(red: 0.96, green: 0.55, blue: 0.15, alpha: 1),
            Color(red: 1, green: 0.1, blue: 0.06, alpha: 1),
            Color(red: 1, green: 0.27, blue: 0.69, alpha: 1),
            Color(red: 0.71, green: 0.35, blue: 0.89, alpha: 1),
            Color(red: 0.29, green: 0.32, blue: 0.92, alpha: 1)
        ]
    }()
}
