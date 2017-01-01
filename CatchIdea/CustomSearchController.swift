//
//  CustomSearchController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/30.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit
protocol CustomSearchControllerDelegate {
    func didChangeSearchTextInSearchBar(_ searchBar:CustomSearchBar,searchText:String)
}

class CustomSearchController: UISearchController {

    internal let customSearchBar = CustomSearchBar()
    
    internal var searchDelegate : CustomSearchControllerDelegate?

    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        customSearchBar.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard  let bar = searchBar as? CustomSearchBar else {return}
        searchDelegate?.didChangeSearchTextInSearchBar(bar, searchText: searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar(searchBar, textDidChange: "")
        searchBar.resignFirstResponder()
    }
}
