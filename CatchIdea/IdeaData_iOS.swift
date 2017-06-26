//
//  IdeaData_iOS.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

extension IdeaData :MarkColor {
    
    typealias Color = UIColor
    
    func markColor()-> UIColor{
        if (self._markColor != nil)&&(self._markColor is UIColor) {
            return self._markColor as! UIColor
        }else{
            return Theme.shared.markColors[0]
        }
    }
    
    func setMarkColor(_ markColor: UIColor) {
        self._markColor = markColor
    }
}
