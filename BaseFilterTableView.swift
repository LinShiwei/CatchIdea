//
//  BaseFilterTableView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation

class BaseFilterTableView: TableView {
    
    internal var ideaData = [IdeaData](){
        didSet{
            filteredIdeaData = ideaData
        }
    }
    
    internal var filteredIdeaData = [IdeaData]()
    
    internal var filterColor = Color.white
    internal var filterText = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            if filterColor != Color.white, !(filterColor ~= idea.markColor){
                matchColor = false
            }
            return containText && matchColor
        }
        super.reloadData()
    }
    
   
}
