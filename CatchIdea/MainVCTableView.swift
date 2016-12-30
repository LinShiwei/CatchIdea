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

    internal var filteredIdeaData = [IdeaData]()
    
    fileprivate var filterColor = UIColor.white
    fileprivate var filterText = ""
    
    private var filterView: IdeaFilterView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.red

        if let headerView = tableHeaderView as? IdeaFilterView {
            filterView = headerView
            filterView?.filterDelegate = self
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func reloadData(){
        filteredIdeaData = ideaData.filter{ (idea: IdeaData) -> Bool in
            var containText = true
            if filterText != "", !idea.header.contains(filterText){
                containText = false
            }else{
                containText = true
            }
            
            var matchColor = true
            if filterColor != UIColor.white, filterColor != idea.markColor{
                matchColor = false
            }
            return containText && matchColor
        }
        super.reloadData()
    }
}

extension MainVCTableView: IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColor color: UIColor) {
        filterColor = color
        filterText = text
        reloadData()
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
