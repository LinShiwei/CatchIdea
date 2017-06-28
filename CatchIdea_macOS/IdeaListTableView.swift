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
        var tempFilterIdeaData = filteredIdeaData
        for i in 0...ideaData.count-1 {
            if ideaData[i] == filteredIdeaData[index] {
                ideaData.remove(at: i)
                break
            }
        }
        tempFilterIdeaData.remove(at: index)
        filteredIdeaData = tempFilterIdeaData
        
        beginUpdates()
        removeRows(at: [index], withAnimation: NSTableViewAnimationOptions.slideRight)
        endUpdates()
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
