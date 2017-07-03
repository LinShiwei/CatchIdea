//
//  IdeaItemEntity+CoreDataProperties.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation
import CoreData


extension IdeaItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IdeaItemEntity> {
        return NSFetchRequest<IdeaItemEntity>(entityName: "IdeaItemEntity")
    }

    @NSManaged public var header: String?
    @NSManaged public var content: String?
    @NSManaged public var addingDate: NSDate?
    @NSManaged public var notificationDate: NSDate?
    @NSManaged public var isFinish: Bool
    @NSManaged public var isDelete: Bool

}
