//
//  TrashViewController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/18.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class TrashViewController: UIViewController {
    
    fileprivate var ideaDataManager = DataManager.shared
    fileprivate var deletedIdeas = [IdeaData]()
    
    @IBOutlet weak var trashTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ideaDataManager.getAllIdeaData(type:.deleted){[unowned self](success,ideas) in
            if (success&&(ideas != nil)){
                self.deletedIdeas = ideas!
                self.trashTableView.reloadData()
            }
        }
    }
}

extension TrashViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}

extension TrashViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deletedIdeas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrashTableViewCell", for: indexPath) as! TrashTableViewCell
        cell.delegate = self
        cell.header = deletedIdeas[indexPath.row].header
        
        return cell
    }
}

extension TrashViewController : IdeaCellManagerDelegate {
    func deleteIdea(sender: UITableViewCell){
        guard let indexPath = trashTableView.indexPath(for: sender) else {return}
        ideaDataManager.deleteOneIdeaData(type: .deleted, ideaData: deletedIdeas[indexPath.row])
        deletedIdeas.remove(at: indexPath.row)
        trashTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
