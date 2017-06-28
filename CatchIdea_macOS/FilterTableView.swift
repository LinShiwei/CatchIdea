//
//  FilterTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class FilterTableView: BaseFilterTableView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
    }
    
    
    func clickAtMarkColorCellToDelete(sender: NSGestureRecognizer){
        //Should override
    }
    
    func clickAtInteractView(sender: NSGestureRecognizer) {
        //Should override
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

extension FilterTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let table = tableView as? FilterTableView else {
            return 0
        }
        return table.filteredIdeaData.count
        
    }
}
