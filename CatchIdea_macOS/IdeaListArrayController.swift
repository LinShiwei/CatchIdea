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

    
//点击按钮触发arrayController 的add action，就是下面这个add:函数，
//在 super.add(sender) 里面调用了 nsmanagedobject 里的 awakeFromInsert: 。创建一个新的 nsmanagedObject 插入到 managedContext 
//然后由于 managedContext 发生了变化，将调用下面的 addObject: 在 arrayController 里添加对象。
    override func add(_ sender: Any?) {
        super.add(sender)
    }
    
    override func addObject(_ object: Any) {
        super.addObject(object)
        
    }
}


//header == 'Empty8989'"
