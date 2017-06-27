//
//  IdeaListTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class IdeaListTableView: BaseFilterTableView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
    }
    
    
    func clickAtMarkColorCellToDelete(sender: NSGestureRecognizer){
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
}


extension IdeaListTableView: NSTableViewDelegate {
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
                cell.textField?.stringValue = filteredIdeaData[row].header
                
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
}

extension IdeaListTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let table = tableView as? IdeaListTableView else {
            return 0
        }
        return table.filteredIdeaData.count
        
    }
}
