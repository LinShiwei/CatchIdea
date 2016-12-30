//
//  CustomSearchBar.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/30.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    override func draw(_ rect: CGRect) {
        if let index = indexOfSearchFieldInSubviews() {
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: frame.size.width - 10.0, height: frame.size.height - 10.0)
            
            searchField.backgroundColor = barTintColor
        }
        
        super.draw(rect)
    }
    
    
    func indexOfSearchFieldInSubviews() -> Int! {
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

}
