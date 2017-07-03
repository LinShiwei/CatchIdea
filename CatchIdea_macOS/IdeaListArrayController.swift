//
//  IdeaListArrayController.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class IdeaListArrayController: NSArrayController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fetchPredicate = NSPredicate(format: "(isDelete == nil || isDelete == false) && (isFinish == nil || isFinish == false) ", argumentArray: nil)
    }

}


//header == 'Empty8989'"
