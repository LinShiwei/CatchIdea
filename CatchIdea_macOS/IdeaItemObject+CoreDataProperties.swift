//
//  IdeaItemObject+CoreDataProperties.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/4.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation
import Cocoa
import CoreData


extension IdeaItemObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IdeaItemObject> {
        return NSFetchRequest<IdeaItemObject>(entityName: "IdeaItemObject")
    }

    @NSManaged public var addingDate: NSDate?
    @NSManaged public var content: String?
    @NSManaged public var header: String?
    @NSManaged public var isDelete: Bool
    @NSManaged public var isFinish: Bool
    @NSManaged public var markColor: NSObject?
    @NSManaged public var notificationDate: NSDate?

    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        addingDate = NSDate()
        content = ""
        header = "Create new idea."
        isDelete = false
        isFinish = false
//        markColor = NSColor.blue 
        //Setting markColor directly to NSColor will cause error.
        //Should set markColor as NSData with NSKeyedArchiver. Because this property is tranformable and is encode with nskeyarchiver.
        //On binding, should select 'value transformer' to nskeyunachiverfromdata
        markColor = NSKeyedArchiver.archivedData(withRootObject: NSColor.red) as NSObject
        notificationDate = nil
        
        
    }
}
