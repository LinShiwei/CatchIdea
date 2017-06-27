//
//  TrashTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class TrashTableView: BaseFilterTableView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dataSource = self
        delegate = self
    }
}
extension TrashTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier = ""
        
        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = "MarkColorCell"
        }else{
            cellIdentifier = "ContentCell"
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.wantsLayer = true
            cell.layer?.backgroundColor = CGColor.black
            return cell
        }
        
        return nil
    }
}

extension TrashTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let _ = tableView as? TrashTableView else {
            return 0
        }
        return 4
        
    }
    
    
}
