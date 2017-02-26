//
//  UITableView+addTopDecorateView.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation

internal extension UITableView {
    internal func addTopDecorateView(){
        let decorateViewHeight: CGFloat = 100
        let decorateView = TableViewTopBounceDecorateView(frame: CGRect(x: 0, y: -decorateViewHeight, width: self.frame.width, height: decorateViewHeight))
        addSubview(decorateView)
        
    }
}
