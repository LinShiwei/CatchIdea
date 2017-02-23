//
//  InfoTableView.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/23.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class InfoTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tableFooterView = UIView()
    }
}
