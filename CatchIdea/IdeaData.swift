//
//  IdeaData.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import Foundation

internal class IdeaData {
    //These properties should store in CoreData
    internal let addingDate: Date
    internal var content: String?
    internal var header: String
    internal var isFinish: Bool
    internal var isDelete: Bool
    internal var notificationDate: Date?
    
    //These propertise don't need to store 
    internal var identifier: String {
        get{
            return addingDate.description
        }
    }
    internal init(addingDate: Date, header: String, content: String?=nil,isFinish: Bool=false, isDelete: Bool=false, notificationDate: Date?=nil) {
        self.addingDate = addingDate
        self.header = header
        self.content = content
        self.isFinish = isFinish
        self.isDelete = isDelete
        self.notificationDate = notificationDate
    }
}
