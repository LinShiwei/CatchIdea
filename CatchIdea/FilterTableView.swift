//
//  FilterTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class FilterTableView: UITableView {

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
            if filterColor != UIColor.white, !(filterColor ~= idea.markColor){
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

extension FilterTableView: IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColor color: UIColor) {
        filterColor = color
        filterText = text
        reloadData()
    }

}

extension FilterTableView: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let dic = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17)
        ]
        let text = NSAttributedString(string: LocalizationStrings.shared.tableEmptyDefaultString, attributes: dic)
        
        return text
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
