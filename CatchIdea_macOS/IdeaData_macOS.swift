//
//  IdeaData_macOS.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import AppKit

extension IdeaData :MarkColor {
    
    typealias Color = NSColor
    
    func markColor()-> NSColor{
        if (self._markColor != nil)&&(self._markColor is NSColor) {
            return self._markColor as! NSColor
        }else{
            return NSColor.white
        }
    }
    
    func setMarkColor(_ markColor: NSColor) {
        self._markColor = markColor
    }
}
