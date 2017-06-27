//
//  MainViewController.swift
//  CatchIdea_macOS
//
//  Created by Lin,Shiwei on 2017/6/25.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var ideaTableView: BaseFilterTableView!
    @IBOutlet weak var trashTableView: BaseFilterTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
//        DataManager.shared.saveOneIdeaData(ideaData: IdeaData(addingDate: Date(), header: "newItem"), { Void in
//            DataManager.shared.getAllIdeaData(type: .all, {(success,ideas) in
//                print(success)
//                print(ideas?.count)
//                
//            })
//        })
//        
//        DataManager.shared.getAllIdeaData(type: .all, {(success,ideas) in
//            print(!success)
//            print(ideas?.count)
//            
//        })
    }

    override func viewWillAppear() {
        DataManager.shared.getAllIdeaData(type: .all, {[weak self](success, ideas) in
            
        })
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension MainViewController: NSTableViewDelegate {
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

extension MainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let identifier = tableView.identifier else {
            return 0
        }
        switch identifier {
        case "IdeaTableView":
            return 1
        case "TrashTableView":
            return 2
        default:
            fatalError()
        }
            
    }
    
    
}
