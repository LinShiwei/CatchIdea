//
//  TrashArrayController.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class TrashArrayController: NSArrayController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fetchPredicate = NSPredicate(format: "(isDelete == true || isFinish == true) ")
    }
}
