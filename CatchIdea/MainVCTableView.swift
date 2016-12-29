//
//  MainVCTableView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/24.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MainVCTableView: UITableView {

    internal var ideaData = [IdeaData](){
        didSet{
            filteredIdeaData = ideaData
        }
    }

    private var filteredIdeaData = [IdeaData]()
    private var searchBar: UISearchBar?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.red
        if let bar = tableHeaderView as? UISearchBar {
            bar.delegate = self
            searchBar = bar
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    fileprivate func filterContent(filter:(IdeaData)->Bool){
        
    }
}

extension MainVCTableView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}

extension MainVCTableView: IdeaCellManagerDelegate{
    func deleteIdea(sender: UITableViewCell){
        guard let indexPath = self.indexPath(for: sender) else {return}
        DataManager.shared.deleteOneIdeaData(deleteStyle: .moveToTrash, ideaData: ideaData[indexPath.row])
        ideaData.remove(at: indexPath.row)
        self.deleteRows(at: [indexPath], with: .fade)
    }
    
    func finishIdea(sender: UITableViewCell){
        guard let indexPath = self.indexPath(for: sender) else {return}
        DataManager.shared.finishOneIdeaData(ideaData: ideaData[indexPath.row])
        ideaData.remove(at: indexPath.row)
        self.deleteRows(at: [indexPath], with: .fade)
    }
}
