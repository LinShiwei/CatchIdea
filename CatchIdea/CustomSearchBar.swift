//
//  CustomSearchBar.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/30.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    private func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        
        return index
    }
    
    override func resignFirstResponder() -> Bool {
        self.delegate?.searchBar?(self, textDidChange: "")
        text = ""
        super.resignFirstResponder()
        setShowsCancelButton(false, animated: true)
        return true
    }
}
