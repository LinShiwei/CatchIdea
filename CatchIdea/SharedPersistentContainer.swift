//
//  SharedPersistentContainer.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/18.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import CoreData

class SharedPersistentContainer: NSPersistentContainer {

    override static func defaultDirectoryURL()-> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.catchidea.linshiwei")!
    }
}
