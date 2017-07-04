//
//  MarkColorCell.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class MarkColorCell: NSTableCellView {

//    var markColorView: MarkColorView
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder: NSCoder) {
//        markColorView = MarkColorView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        
        super.init(coder: coder)
//        addSubview(markColorView)

//        markColorButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        markColorButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func layout() {
        super.layout()
        
//        markColorView.frame.origin = CGPoint(x: frame.width/4, y: frame.height/4)
    }
}
