//
//  DataManager.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import Foundation
import CoreData


internal enum IdeaDataType {
    case existed,deleted,all
}

internal enum DeleteStyle {
    case moveToTrash,deleteForever
}


#if os(iOS)
    import UIKit
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

#else
#if os(macOS)
    import Cocoa
    let appDelegate = NSApplication.shared().delegate as! AppDelegate
#endif
    //fatal error
 
#endif



internal final class DataManager: NSObject {

    private let entityName = "Idea"

    static let shared = DataManager()
    
    //objects 里的数据是按照 date 由新到旧排列，最新的数据在［0］。
    //newest ideaData in objects is at index 0.
    dynamic private var objects = [NSManagedObject]()

    private override init(){
        super.init()
    }

    //Should call getAllIdeaData: before calling any other method in DataManager
    //MARK: Public API - Get
    internal func getAllIdeaData(type: IdeaDataType, _ completion: @escaping (Bool,[IdeaData]?)->Void) {
        getIdeaDataObjects{[unowned self] success in
            switch type {
            case .existed:
                self.getIdeaData(filter: {$0.value(forKey: "isDelete") as? Bool == false}, completion)
            case .deleted:
                self.getIdeaData(filter: {$0.value(forKey: "isDelete") as? Bool == true}, completion)
            case .all:
                self.getIdeaData(filter: {_ in return true}, completion)
            }
        }
    }
    
    //MARK: Public API - Delete
    internal func deleteAllIdeaDataInTrash(_ completion:((Bool)->Void)?=nil){
        var findObject = false
        let managedContext = getManagedContext()
        var reservedObjects = objects
        for (index,object) in objects.enumerated().reversed() where object.value(forKey: "isDelete") as! Bool == true {
            managedContext.delete(object)
            reservedObjects.remove(at: index)
            findObject = true
        }
        objects = reservedObjects
        managedContextSave()
        completion?(findObject)
    }

    internal func deleteOneIdeaData(deleteStyle: DeleteStyle, ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        switch deleteStyle {
        case .moveToTrash:
            deleteOneIdeaDataToTrash(ideaData: ideaData, completion)
        case .deleteForever:
            deleteOneIdeaDataForever(ideaData: ideaData, completion)
        }
        LocalNotificationManager.shared.deletePendingNotification(withIdeaData: ideaData)
    }
    
    internal func finishOneIdeaData(ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(true, forKey: "isFinish")
        }
        deleteOneIdeaDataToTrash(ideaData: ideaData, completion)
    }
    internal func deleteIdeaDataNotification(ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        var findObject = false
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(nil, forKey: "notificationDate")
            findObject = true
        }
        managedContextSave()
        LocalNotificationManager.shared.deletePendingNotification(withIdeaData: ideaData)
        completion?(findObject)
    }
    
    
    //MARK: Public API - Restore
    internal func restoreOneIdeaData(ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        var findObject = false
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(false, forKey: "isFinish")
            object.setValue(false, forKey: "isDelete")
            findObject = true
        }
        managedContextSave()
        completion?(findObject)
    }
    
    //MARK: Public API - Save
    internal func saveOneIdeaData(ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        objects.insert(createIdeaObject(fromIdeaData: ideaData), at: 0)
        managedContextSave()
        LocalNotificationManager.shared.createNewNotification(withIdeaData: ideaData)
        completion?(true)
    }
    
    //MARK: Private help func
    private func getIdeaData(filter: ((NSManagedObject)->Bool), _ completion: @escaping (Bool,[IdeaData]?)->Void) {
        var ideas = [IdeaData]()
        for object in objects{
            #if os(iOS)
                CoreDataStack.persistentContainer.viewContext.refresh(object, mergeChanges: true)
            #endif
            if filter(object) {
                if let addingDate = object.value(forKey: "addingDate") as? Date,
                    let header = object.value(forKey: "header") as? String ,
                    let isFinish = object.value(forKey: "isFinish") as? Bool,
                    let isDelete = object.value(forKey: "isDelete") as? Bool,
                    let markColor = object.value(forKey: "markColor") as? Color,
                    let content = object.value(forKey: "content") as? String {
                    
                    let notificationDate = object.value(forKey: "notificationDate") as? Date
                    if (notificationDate != nil)&&(notificationDate! <= Date()) {
                        ideas.append(IdeaData(addingDate: addingDate, header: header, content: content,isFinish: isFinish,isDelete: isDelete, markColor: markColor, notificationDate:nil))
                        object.setValue(nil, forKey: "notificationDate")
                        managedContextSave()
                    }else{
                        ideas.append(IdeaData(addingDate: addingDate, header: header, content: content,isFinish: isFinish,isDelete: isDelete, markColor: markColor, notificationDate:notificationDate))
                    }
                }
            }
        }
        
        completion(true,ideas)
    }
    
    private func deleteOneIdeaDataForever(ideaData: IdeaData, _ completion: ((Bool)->Void)?=nil){
        var findObject = false
        let managedContext = getManagedContext()
        let count = objects.count
        for (index,object) in objects.enumerated() where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            managedContext.delete(object)
            managedContextSave()
            objects.remove(at: index)
            findObject = true
        }
//        print("delete")
//        print(count - objects.count)
        assert(objects.count == count - 1)
        completion?(findObject)
    }
    
    private func deleteOneIdeaDataToTrash(ideaData: IdeaData, _ completion: ((Bool)->Void)?=nil){
        var findObject = false
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(true, forKey: "isDelete")
            managedContextSave()
            findObject = true
        }
        completion?(findObject)
    }
    
    private func getIdeaDataObjects(_ completion: @escaping ((Bool)->Void)){
        if objects.count == 0 {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]
            do {
                objects = try getManagedContext().fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            if objects.count > 0 {
                completion(true)
            }else{
                //当要使用模拟数据的时候，解除下注释
//                saveMockIdeaData(ideas: mockIdeaData(),completion)
                let userDefault = UserDefaults.standard
                if let hasCreateMockData = userDefault.value(forKey: "HasCreateMockData") as? Bool, hasCreateMockData == true{
                    completion(true)
                }else{
                    saveMockIdeaData(ideas: guidelineMockIdeaData(), completion)
                    userDefault.set(true, forKey: "HasCreateMockData")
//                    completion(true)
                }
            }
        }else{
            completion(true)
        }
    }
  
    private func saveMockIdeaData(ideas: [IdeaData],_ completion: @escaping ((Bool)->Void)) {
        DispatchQueue.global().async {[unowned self] in
            for idea in ideas {
                self.objects.append(self.createIdeaObject(fromIdeaData: idea))
            }
            self.managedContextSave()
            completion(true)
        }
    }
    
    private func createIdeaObject(fromIdeaData idea: IdeaData)->NSManagedObject{
        let managedContext = self.getManagedContext()
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: managedContext)
        let ideaObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        ideaObject.setValue(idea.addingDate, forKey: "addingDate")
        ideaObject.setValue(idea.header, forKey: "header")
        ideaObject.setValue(idea.content, forKey: "content")
        ideaObject.setValue(idea.isDelete, forKey: "isDelete")
        ideaObject.setValue(idea.isFinish, forKey: "isFinish")
        ideaObject.setValue(idea.markColor, forKey: "markColor")
        ideaObject.setValue(idea.notificationDate, forKey: "notificationDate")
        return ideaObject
    }
    
    private func mockIdeaData()->[IdeaData] {
        var ideas = [IdeaData]()
        var date = Date(timeIntervalSinceReferenceDate: 0)
        for _ in 0...20 {
            let header = date.description
            let content = date.description
            date.addTimeInterval(-100)
            ideas.append(IdeaData(addingDate: date, header: header, content: content))
        }
        return ideas
    }
    
    private func guidelineMockIdeaData()->[IdeaData]{
        var ideas = [IdeaData]()
        let date = Date(timeIntervalSinceReferenceDate: 0)
        let idea1 = IdeaData(addingDate: date, header: LocalizationStrings.shared.mainTableDefaultCellTitle)
        ideas.append(idea1)
        
        return ideas
    }
    
    private func getManagedContext()->NSManagedObjectContext{
        return appDelegate.persistentContainer.viewContext
    }
    
    private func managedContextSave(){
        appDelegate.saveAction(nil)
    }
}
