//
//  MainViewController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MainViewController: UIViewController {

    fileprivate let ideaDataManager = DataManager.shared
    
    fileprivate var existedIdeas = [IdeaData]()
    
    @IBOutlet weak var ideaListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ideaDataManager.getAllIdeaData(type:.existed){[unowned self](success,ideas) in
            if (success&&(ideas != nil)){
                self.existedIdeas = ideas!
                self.ideaListTableView.reloadData()
            }
        }
    }
    

}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

}

extension MainViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existedIdeas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdeaListTableViewCell", for: indexPath) as! IdeaListTableViewCell
        
        cell.delegate = self
        cell.header = existedIdeas[indexPath.row].header
        
        return cell
    }
}

extension MainViewController : IdeaCellManagerDelegate {
    func deleteIdea(sender: IdeaListTableViewCell){
        guard let indexPath = ideaListTableView.indexPath(for: sender) else {return}
        ideaDataManager.deleteOneIdeaData(type: .existed, ideaData: existedIdeas[indexPath.row])
        existedIdeas.remove(at: indexPath.row)
        ideaListTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func finishIdea(sender: IdeaListTableViewCell){
        
    }
}
