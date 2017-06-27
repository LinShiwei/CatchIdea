//
//  MarkColorButton.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class MarkColorView: NSView {

    internal var markColor = NSColor.red{
        didSet{
            layer?.backgroundColor = markColor.cgColor
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.cornerRadius = self.frame.width/2
        layer?.backgroundColor = NSColor.green.cgColor
        
        
//        stringValue = ""
//        image = nil
//        print(cell)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
