//
//  Define.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation

let markColorCellIdentifier = "MarkColorCell"
let contentCellIdentifier = "ContentCell"

let tabIdeaItemIdentifier = "IdeaItem"
let tabTrashItemIdentifier = "TrashItem"

class ICloudDashBoardKey: NSObject {
    static let recordType = "IdeaItem"
    static let notificationCreate = "Create"
    static let notificationUpdate = "Update"
    static let notificationDelete = "Delete"

}

class CoreDataModelKey: NSObject {
    static let entityName = "IdeaItemObject"
    
    static let header = "header"
    static let content = "content"
    static let isDelete = "isDelete"
    static let isFinish = "isFinish"
    static let addingDate = "addingDate"
    static let notificationDate = "notificationDate"
    static let markColorIndex = "markColorIndex"
    static let uuidString = "uuidString"
}
