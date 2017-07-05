//
//  TrashContentCell.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class TrashContentCell: NSTableCellView {

    @IBOutlet weak var deleteButton: NSButton!
    
    @IBAction func restoreIdea(_ sender: Any) {
        
    }
    @IBAction func deleteIdeaForever(_ sender: Any) {
        if let obj = objectValue {
            guard let arrayController = (self.window?.contentViewController as? MainViewController_macOS)?.trashArrayController else {
                return
            }
            arrayController.removeObject(obj)
        }
        
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
}
