//
//  ContentCellInteractView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/28.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class ContentCellInteractView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.cornerRadius = frame.width/2
        layer?.backgroundColor = NSColor.red.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
