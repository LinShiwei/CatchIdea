//
//  IdeaData.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import Foundation

internal class IdeaData {
    
    internal let addingDate: Date
    internal var content: String?
    internal var header: String
    internal var isFinish: Bool
    internal var isDelete: Bool
    
    internal init(addingDate: Date, header: String, content: String?=nil,isFinish: Bool=false, isDelete: Bool=false) {
        self.addingDate = addingDate
        self.header = header
        self.content = content
        self.isFinish = isFinish
        self.isDelete = isDelete
    }
}
