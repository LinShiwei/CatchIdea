//
//  MainVCTableView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/24.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MainVCTableView: FilterTableView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    internal func checkoutCellsNotification(){
        for cell in visibleCells {
            if let ideaCell = cell as? IdeaListTableViewCell {
                ideaCell.checkoutCellNotification()
            }
        }
    }
}


extension MainVCTableView{
    
    override func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let dic = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17)
        ]
        let text = NSAttributedString(string: LocalizationStrings.shared.mainTableEmptyString, attributes: dic)
        return text
    }
}

