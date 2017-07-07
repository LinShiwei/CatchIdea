//
//  FilterManager.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/29.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class FilterManager: NSObject {
    static let shared = FilterManager()
    
    internal var filterDelegate: IdeaFilterDelegate?
    
    fileprivate var ideaSearchText = ""
    fileprivate var ideaMarkColorIndex = 0
    
    
    private override init() {
        super.init()
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        guard let searchField = obj.object as? NSSearchField else{
            return
        }
        ideaSearchText = searchField.stringValue
        filterDelegate?.filterIdea(withSearchText: ideaSearchText, andMarkColorIndex: ideaMarkColorIndex)
    }
}

extension FilterManager: ColorSelectionDelegate {
    func didSelectColor(ofColorIndex index: Int) {
        ideaMarkColorIndex = index
        filterDelegate?.filterIdea(withSearchText: ideaSearchText, andMarkColorIndex: index)
    }
}

extension FilterManager: NSSearchFieldDelegate{
    
}
