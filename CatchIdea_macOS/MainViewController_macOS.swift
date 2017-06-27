//
//  MainViewController.swift
//  CatchIdea_macOS
//
//  Created by Lin,Shiwei on 2017/6/25.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class MainViewController_macOS: NSViewController {

    @IBOutlet weak var ideaListTableView: IdeaListTableView!
    @IBOutlet weak var TrashTableView: TrashTableView!
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
            if (success&&(ideas != nil)){
                var existedIdeas = [IdeaData]()
                for idea in ideas! {
                    if idea.isDelete == true {
                    }else{
                        existedIdeas.append(idea)
                    }
                }
                self?.ideaListTableView.ideaData = existedIdeas
                DispatchQueue.main.async {
                    self?.ideaListTableView.reloadData()
                }
            }
        })
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func addOneIdea(_ sender: Any) {
        let idea = IdeaData(addingDate: Date(), header: Date().description)
        DataManager.shared.saveOneIdeaData(ideaData: idea)
        ideaListTableView.ideaData.insert(idea, at: 0)
        ideaListTableView.reloadData()
    }

}

