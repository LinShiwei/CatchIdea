//
//  FilterTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class FilterTableView: BaseFilterTableView {
    //Should override and set to true in order to enable content cell gesture
    internal var isCellClickEnable: Bool {
        get{
            return false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionHighlightStyle = .none
        dataSource = self
        delegate = self
    }
    
    
    func clickAtMarkColorCellToDelete(sender: NSGestureRecognizer){
        //Should override
    }
    
    func clickAtInteractView(sender: NSGestureRecognizer) {
        //Should override
    }
    
    func clickAtContentCell(sender: NSGestureRecognizer) {
        //option override
    }
}


extension FilterTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier = ""
        
        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = markColorCellIdentifier
        }else{
            cellIdentifier = contentCellIdentifier
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            
            switch cellIdentifier {
            case markColorCellIdentifier:
                
                guard let markColorCell = cell as? MarkColorCell else {
                    return nil
                }
                markColorCell.markColorView.markColor = filteredIdeaData[row].markColor
                let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(clickAtMarkColorCellToDelete(sender:)))
                markColorCell.markColorView.addGestureRecognizer(clickGesture)
                
            case contentCellIdentifier:
                guard let contentCell = cell as? ContentCell else {
                    return nil
                }
                contentCell.textField?.stringValue = filteredIdeaData[row].header
                let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(clickAtInteractView(sender:)))
                contentCell.interactView.addGestureRecognizer(clickGesture)
                contentCell.textField?.isEditable = true
                contentCell.textField?.delegate = self
                if isCellClickEnable {
                    let cellClickGesture = NSClickGestureRecognizer(target: self, action: #selector(clickAtContentCell(sender:)))
                    contentCell.addGestureRecognizer(cellClickGesture)
                }
                
                
            default:
                fatalError()
            }
            
            return cell
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
    
//    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
//        return false
//    }
}

extension FilterTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let table = tableView as? FilterTableView else {
            return 0
        }
        return table.filteredIdeaData.count
        
    }
}

extension FilterTableView: NSTextFieldDelegate {
//    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
//        if commandSelector == #selector(insertNewline(_:)) {
//            
//            guard let cell = control.superview as? NSTableCellView else{
//                return false
//            }
//            let row = self.row(for: cell)
//            //            control.superview
//            guard row > -1 && row < filteredIdeaData.count else {
//                return false
//            }
//            let idea = filteredIdeaData[row]
//            DataManager.shared.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: idea)
//            
//            let newIdea = IdeaData(addingDate: Date(), header: control.stringValue, content: idea.content, isFinish: idea.isFinish, isDelete: idea.isDelete, markColor: idea.markColor, notificationDate: idea.notificationDate)
//            DataManager.shared.saveOneIdeaData(ideaData: newIdea)
//            
//        }
//
//        return false
//    }
    
    override func textDidEndEditing(_ notification: Notification) {
        
        guard let field = notification.object as? NSTextField else {
            return
        }
        
        guard let cell = field.superview as? NSTableCellView else{
            return
        }
        let row = self.row(for: cell)
        //            control.superview
        guard row > -1 && row < filteredIdeaData.count else {
            return
        }
        let idea = filteredIdeaData[row]
        DataManager.shared.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: idea)
        
        let newIdea = IdeaData(addingDate: Date(), header: field.stringValue, content: idea.content, isFinish: idea.isFinish, isDelete: idea.isDelete, markColor: idea.markColor, notificationDate: idea.notificationDate)
        DataManager.shared.saveOneIdeaData(ideaData: newIdea)

        for i in 0...ideaData.count-1 {
            if ideaData[i] == filteredIdeaData[row] {
                ideaData.remove(at: i)
                break
            }
        }
        filteredIdeaData.remove(at: row)
        

    }
}
