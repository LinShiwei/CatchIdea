//
//  ContentTabView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/28.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class ContentTabView: NSTabView {

    internal var selectedItemIdentifier: String{
        get{
            guard let identifier = self.selectedTabViewItem?.identifier as? String else {
                return ""
            }
            return identifier
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
