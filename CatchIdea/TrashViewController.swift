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
    
    @IBOutlet weak var trashTableView: TrashTableView!
    @IBOutlet weak var backToMainVCButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ideaDataManager.getAllIdeaData(type:.deleted){[unowned self](success,ideas) in
            if (success&&(ideas != nil)){
                self.trashTableView.ideaData = ideas!
                self.trashTableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let _ = trashTableView.resignFirstResponder()
        super.viewWillDisappear(animated)   
    }
    
    @IBAction func clearTrashForever(_ sender: Any) {
        guard trashTableView.numberOfRows(inSection: 0) > 0 else {return}
        let alert = UIAlertController(title: "清空纸篓", message: "确定要清空纸篓吗？此操作不可恢复。", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "确定", style: .default,handler: { (action:UIAlertAction) -> Void in
            self.ideaDataManager.deleteAllIdeaDataInTrash(){[unowned self] success in
                if success {
                    self.trashTableView.ideaData.removeAll()
                    self.trashTableView.reloadData()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .default) { (action: UIAlertAction) -> Void in }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissTrashVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToResignFirstResponder(_ sender: Any) {
        let _ = trashTableView.resignFirstResponder()
    }
}

extension TrashViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.borderWidth = 0
    }
}

extension TrashViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let table = tableView as? TrashTableView else {
            return 0
        }
        return table.filteredIdeaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrashTableViewCell", for: indexPath) as! TrashTableViewCell
        if let table = tableView as? TrashTableView {
            cell.delegate = table
            cell.ideaData = table.filteredIdeaData[indexPath.row]
        }
        return cell
    }
}
//
//extension TrashViewController : IdeaCellManagerDelegate {
//    func deleteIdea(sender: UITableViewCell){
//        guard let indexPath = trashTableView.indexPath(for: sender) else {return}
//        ideaDataManager.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: deletedIdeas[indexPath.row])
//        deletedIdeas.remove(at: indexPath.row)
//        trashTableView.deleteRows(at: [indexPath], with: .fade)
//    }
//    
//    func restoreIdea(sender: UITableViewCell) {
//        guard let indexPath = trashTableView.indexPath(for: sender) else {return}
//        ideaDataManager.restoreOneIdeaData(ideaData: deletedIdeas[indexPath.row])
//        deletedIdeas.remove(at: indexPath.row)
//        trashTableView.deleteRows(at: [indexPath], with: .fade)
//    }
//}
