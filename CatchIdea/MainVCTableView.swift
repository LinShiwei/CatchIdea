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
        if let headerView = tableHeaderView as? IdeaFilterView {
            filterView = headerView
            filterView?.filterDelegate = self
        }
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
//                
//                var r: CGFloat = 0
//                var g: CGFloat = 0
//                var b: CGFloat = 0
//                var a: CGFloat = 0
//                filterColor.getRed(&r, green: &g, blue: &b, alpha: &a)
//                
//                
////                print("\(idea.markColor)  \(filterColor)")
//                print("bbbb\(r) \(g) \(b)")
//                idea.markColor.getRed(&r, green: &g, blue: &b, alpha: &a)
//                
//                print("\(r) \(g) \(b)")
//                
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
    
    internal func checkoutCellsNotification(){
        for cell in visibleCells {
            if let ideaCell = cell as? IdeaListTableViewCell {
                ideaCell.checkoutCellNotification()
            }
        }
    }
}

extension MainVCTableView: IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColor color: UIColor) {
        filterColor = color
        filterText = text
        reloadData()
    }
}



