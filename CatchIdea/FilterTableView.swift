//
//  FilterTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class FilterTableView: BaseFilterTableView {

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
