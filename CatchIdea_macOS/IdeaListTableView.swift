//
//  IdeaListTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class IdeaListTableView: FilterTableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func clickAtMarkColorCellToDelete(sender: NSGestureRecognizer){
        guard let v = sender.view as? MarkColorView,let cell = v.superview as? NSTableCellView else {
            return
        }
        let index = self.row(for: cell)
        
        DataManager.shared.deleteOneIdeaData(deleteStyle: .moveToTrash, ideaData: self.ideaData[index])
        self.ideaData.remove(at: index)
        self.beginUpdates()
        self.removeRows(at: [index], withAnimation: NSTableViewAnimationOptions.slideRight)
        self.endUpdates()
    }
    
    internal func refreshIdeaDataAndReload(){
        DataManager.shared.getAllIdeaData(type: .existed, {[weak self](success, ideas) in
            if (success&&(ideas != nil)){
                self?.ideaData = ideas!
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            }
        })
    }
}
