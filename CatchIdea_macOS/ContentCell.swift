//
//  ContentCell.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/28.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class ContentCell: NSTableCellView {

    internal var interactView: ContentCellInteractView
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    
    required init?(coder: NSCoder) {
        interactView = ContentCellInteractView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))

        super.init(coder: coder)
        
        addSubview(interactView)
    }
    
    override func layout() {
        super.layout()
        interactView.frame.origin = CGPoint(x: frame.width-8-interactView.frame.width, y: frame.height/4)
    }
}
