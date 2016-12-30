//
//  ideaFilterView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/30.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

protocol IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColor color: UIColor)
}

class IdeaFilterView: UIView {

    internal var filterDelegate: IdeaFilterDelegate?
    
    private var colorSelectionView: ColorSeletcionView?
    private var searchController: CustomSearchController!
    
    fileprivate var ideaSearchText = ""
    fileprivate var ideaMarkColor = UIColor.white
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.red
        colorSelectionView = viewWithTag(2) as? ColorSeletcionView
        colorSelectionView?.selectionDelegate = self
        
        searchController = CustomSearchController(searchResultsController: nil)
        searchController.searchDelegate = self
        addSubview(searchController.customSearchBar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchController.customSearchBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: 44)
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()    
        return searchController.customSearchBar.resignFirstResponder()

    }
}

extension IdeaFilterView: CustomSearchControllerDelegate {
    func didChangeSearchTextInSearchBar(_ searchBar: CustomSearchBar, searchText: String) {
        ideaSearchText = searchText
        filterDelegate?.filterIdea(withSearchText: ideaSearchText, andMarkColor: ideaMarkColor)
    }
}

extension IdeaFilterView: ColorSelectionDelegate {
    func didSelectColor(_ color: UIColor) {
        ideaMarkColor = color
        filterDelegate?.filterIdea(withSearchText: ideaSearchText, andMarkColor: ideaMarkColor)
    }
}
