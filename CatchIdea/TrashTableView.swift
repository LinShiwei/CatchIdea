//
//  TrashTableView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/1.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class TrashTableView: UITableView {
    
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

        if let headerView = tableHeaderView as? IdeaFilterView {
            filterView = headerView
            filterView?.filterDelegate = self
        }
        emptyDataSetDelegate = self
        emptyDataSetSource = self
        tableFooterView = UIView()
        addTopDecorateView()
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
            if filterColor != UIColor.white, !(filterColor ~= idea.markColor()){
                matchColor = false
            }
            return containText && matchColor
        }
        super.reloadData()
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        let _ = filterView?.resignFirstResponder()
        return true
    }
}

extension TrashTableView: IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColor color: UIColor) {
        filterColor = color
        filterText = text
        reloadData()
    }
}

extension TrashTableView: IdeaCellManagerDelegate{
    func deleteIdea(sender: UITableViewCell){
        guard let indexPath = self.indexPath(for: sender) else {return}
        DataManager.shared.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: ideaData[indexPath.row])
        var tempFilterIdeaData = filteredIdeaData
        for index in 0...ideaData.count-1 {
            if ideaData[index] == filteredIdeaData[indexPath.row]{
                ideaData.remove(at: index)
                break
            }
        }
        tempFilterIdeaData.remove(at: indexPath.row)
        filteredIdeaData = tempFilterIdeaData
        beginUpdates()
        deleteRows(at: [indexPath], with: .left)
        endUpdates()
    }
    
    func restoreIdea(sender: UITableViewCell) {
        guard let indexPath = self.indexPath(for: sender) else {return}
        DataManager.shared.restoreOneIdeaData(ideaData: ideaData[indexPath.row])
        var tempFilterIdeaData = filteredIdeaData
        for index in 0...ideaData.count-1 {
            if ideaData[index] == filteredIdeaData[indexPath.row]{
                ideaData.remove(at: index)
                break
            }
        }
        tempFilterIdeaData.remove(at: indexPath.row)
        filteredIdeaData = tempFilterIdeaData
        beginUpdates()
        deleteRows(at: [indexPath], with: .right)
        endUpdates()
    }
}

extension TrashTableView: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let dic = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17)
        ]
        let text = NSAttributedString(string: LocalizationStrings.shared.trashTableEmptyString, attributes: dic)
        
        return text
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
