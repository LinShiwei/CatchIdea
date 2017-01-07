//
//  UIColor+~=.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func ~= (left: UIColor, right: UIColor)-> Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        left.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        var rr: CGFloat = 0
        var gg: CGFloat = 0
        var bb: CGFloat = 0
        var aa: CGFloat = 0
        right.getRed(&rr, green: &gg, blue: &bb, alpha: &aa)
        
        if fabs(r-rr)<0.2,fabs(g-gg)<0.2,fabs(b-bb)<0.2 {
            return true
        }else{
            return false
        }
    }
}
