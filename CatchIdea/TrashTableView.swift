//
//  TrashTableView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/1.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class TrashTableView: FilterTableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTopDecorateView()
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

extension TrashTableView{
    override func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let dic = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17)
        ]
        let text = NSAttributedString(string: LocalizationStrings.shared.trashTableEmptyString, attributes: dic)
        
        return text
    }
}
