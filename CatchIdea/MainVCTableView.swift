//
//  MainVCTableView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/24.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MainVCTableView: UITableView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.red
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
