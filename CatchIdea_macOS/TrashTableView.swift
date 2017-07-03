//
//  TrashTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

//class TrashTableView: FilterTableView {
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func clickAtMarkColorCellToDelete(sender: NSGestureRecognizer) {
//        guard let v = sender.view as? MarkColorView,let cell = v.superview as? NSTableCellView else {
//            return
//        }
//        let index = self.row(for: cell)
//        
//        DataManager.shared.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: self.ideaData[index])
//        var tempFilterIdeaData = filteredIdeaData
//        for i in 0...ideaData.count-1 {
//            if ideaData[i] == filteredIdeaData[index] {
//                ideaData.remove(at: i)
//                break
//            }
//        }
//        tempFilterIdeaData.remove(at: index)
//        filteredIdeaData = tempFilterIdeaData
//        
//        beginUpdates()
//        removeRows(at: [index], withAnimation: NSTableViewAnimationOptions.slideRight)
//        endUpdates()
//    }
//    
//    override func clickAtInteractView(sender: NSGestureRecognizer) {
//        guard let v = sender.view as? ContentCellInteractView,let cell = v.superview as? NSTableCellView else {
//            return
//        }
//        let index = self.row(for: cell)
//        
//        DataManager.shared.restoreOneIdeaData(ideaData: self.ideaData[index])
//        var tempFilterIdeaData = filteredIdeaData
//        for i in 0...ideaData.count-1 {
//            if ideaData[i] == filteredIdeaData[index] {
//                ideaData.remove(at: i)
//                break
//            }
//        }
//        tempFilterIdeaData.remove(at: index)
//        filteredIdeaData = tempFilterIdeaData
//        
//        beginUpdates()
//        removeRows(at: [index], withAnimation: NSTableViewAnimationOptions.slideRight)
//        endUpdates()
//        
//    }
//    
//    internal func clearTrashForever(){
//        guard self.numberOfRows > 0 && self.numberOfRows == self.ideaData.count else {
//            return
//        }
//        DataManager.shared.deleteAllIdeaDataInTrash({[weak self] success in
//            guard let safeSelf = self else{
//                return
//            }
//            let indexSet = IndexSet(0...safeSelf.numberOfRows-1)
//            safeSelf.ideaData.removeAll()
//            safeSelf.beginUpdates()
//            safeSelf.removeRows(at: indexSet, withAnimation: NSTableViewAnimationOptions.slideRight)
//            safeSelf.endUpdates()
////            safeSelf.reloadData()
//        })
//    }
//    
//    internal func refreshIdeaDataAndReload(){
//        DataManager.shared.getAllIdeaData(type: .deleted, {[weak self](success, ideas) in
//            if (success&&(ideas != nil)){
//                self?.ideaData = ideas!
//                DispatchQueue.main.async {
//                    self?.reloadData()
//                }
//            }
//        })
//    }
//}
