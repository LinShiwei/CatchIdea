//
//  MainViewController.swift
//  CatchIdea_macOS
//
//  Created by Lin,Shiwei on 2017/6/25.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class MainViewController_macOS: NSViewController {

    let filterManager = FilterManager.shared
    
    @IBOutlet var ideaListArrayController: IdeaListArrayController!
    
    @IBOutlet var trashArrayController: TrashArrayController!
    
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var colorFilterView: ColorFilterView!
    
    @IBOutlet weak var contentTabView: ContentTabView!
//    @IBOutlet weak var ideaListTableView: IdeaListTableView!
//    @IBOutlet weak var trashTableView: TrashTableView!
    
    @IBOutlet weak var ideaListTableView: NSTableView!
    @IBOutlet weak var trashTableView: NSTableView!
    
    internal var managedObjectContext: NSManagedObjectContext {
        get{
            return (NSApplication.shared().delegate as! AppDelegate).persistentContainer.viewContext
        }
    }
    
    internal weak var popover: NSPopover? = nil
    
    @IBAction func changeFilter(_ sender: Any) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let man = ICloudManager.shared()
        man?.subscription(withRecordType: "IdeaItem")
        
        
//        man?.save()
        contentTabView.delegate = self
        
        searchField.delegate = filterManager
        colorFilterView.selectionDelegate = filterManager
//        searchField.delegate = self
        filterManager.filterDelegate = self
    }

    override func viewWillAppear() {
//        DataManager.shared.getAllIdeaData(type: .all, {[weak self](success, ideas) in
//            if (success&&(ideas != nil)){
//                var existedIdeas = [IdeaData]()
//                for idea in ideas! {
//                    if idea.isDelete == true {
//                    }else{
//                        existedIdeas.append(idea)
//                    }
//                }
//                self?.ideaListTableView.ideaData = existedIdeas
//                DispatchQueue.main.async {
//                    self?.ideaListTableView.reloadData()
//                }
//            }
//        })
//        
//        DataManager.shared.getAllIdeaData(type: .deleted, {[weak self](success, ideas) in
//            if (success&&(ideas != nil)){
//                self?.trashTableView.ideaData = ideas!
//                DispatchQueue.main.async {
//                    self?.trashTableView.reloadData()
//                    print(self?.trashTableView.numberOfRows)
//                }
//            }
//        })
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func controlTextDidChange(_ obj: Notification) {
        
    }
    
    @IBAction func addOneIdea(_ sender: Any) {//Add or Clean
//        switch contentTabView.selectedItemIdentifier {
//        case tabIdeaItemIdentifier:
//            let idea = IdeaData(addingDate: Date(), header: Date().description)
//            DataManager.shared.saveOneIdeaData(ideaData: idea)
//            ideaListTableView.ideaData.insert(idea, at: 0)
//            ideaListTableView.beginUpdates()
//            ideaListTableView.insertRows(at: [0], withAnimation: NSTableViewAnimationOptions.slideLeft)
//            ideaListTableView.endUpdates()
//
//        case tabTrashItemIdentifier:
//            trashTableView.clearTrashForever()
//            
//            
//        default:
//            return
//        }
//        
        
    }
    
    

}

extension MainViewController_macOS: NSTabViewDelegate {
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
//        guard let identifier = tabViewItem?.identifier as? String else {
//            return
//        }
//        switch identifier {
//        case tabIdeaItemIdentifier:
//            print("select idea")
//            ideaListTableView.refreshIdeaDataAndReload()
//        case tabTrashItemIdentifier:
//            print("select trash")
//            trashTableView.refreshIdeaDataAndReload()
//            
//        default:
//            fatalError()
//        }
    }
}

extension MainViewController_macOS: IdeaFilterDelegate {
//    func filterIdea(withSearchText text: String, andMarkColor color: Color) {
//        ideaListTableView.filterText = text
//        ideaListTableView.filterColor = color
//        trashTableView.filterText = text
//        trashTableView.filterColor = color
//        tabView(contentTabView, didSelect: contentTabView.selectedTabViewItem)
        
//    }
    
    func filterIdea(withSearchText text: String, andMarkColorIndex index: Int) {
        switch contentTabView.selectedItemIdentifier {
        case tabIdeaItemIdentifier:
            if index == 0 {
                if text == "" {
                    ideaListArrayController.fetchPredicate = NSPredicate(format: "(isDelete == false || isDelete == nil) && (isFinish == false || isFinish == nil)", index)
                }else{
                    ideaListArrayController.fetchPredicate = NSPredicate(format: "((header CONTAINS %@)) && (isDelete == false || isDelete == nil) && (isFinish == false || isFinish == nil)",text)
                }

            }else{
                if text == "" {
                    ideaListArrayController.fetchPredicate = NSPredicate(format: "(markColorIndex == %d) && (isDelete == false || isDelete == nil) && (isFinish == false || isFinish == nil)", index)
                }else{
                    ideaListArrayController.fetchPredicate = NSPredicate(format: "((header CONTAINS %@)) && (markColorIndex == %d) && (isDelete == false || isDelete == nil) && (isFinish == false || isFinish == nil)",text,index)
                }
            }
            
        case tabTrashItemIdentifier:
            if index == 0 {
                if text == "" {
                    trashArrayController.fetchPredicate = NSPredicate(format: "(isDelete == true || isFinish == true) ",index)
                    
                }else{
                    trashArrayController.fetchPredicate = NSPredicate(format: "((header CONTAINS %@)) && (isDelete == true || isFinish == true) ",text,index)
                }
            }else{
                if text == "" {
                    trashArrayController.fetchPredicate = NSPredicate(format: "(markColorIndex == %d) && (isDelete == true || isFinish == true) ",index)
                    
                }else{
                    trashArrayController.fetchPredicate = NSPredicate(format: "((header CONTAINS %@)) && (markColorIndex == %d) && (isDelete == true || isFinish == true) ",text,index)
                }
            }
            
            return
        default:
            return
        }

    }
}

