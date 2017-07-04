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
//        fetchPredicate = NSPredicate(format: "(isDelete == true || isFinish == true) ", argumentArray: nil)
        let text = ""
        let index = 0
//        fetchPredicate = NSPredicate(format: "(header CONTAINS %@) &&  (markColorIndex == %d) && (isDelete == true || isFinish == true) ", text,index)
//        fetchPredicate = NSPredicate(format: "((header CONTAINS 'C') || (header MATCHES '')) && (markColorIndex == %d) && (isDelete == true || isFinish == true) ",index)

        fetchPredicate = NSPredicate(format: "(markColorIndex == %d) && (isDelete == true || isFinish == true) ",index)


        
    }
}
