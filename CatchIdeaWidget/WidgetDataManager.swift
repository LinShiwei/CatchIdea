//
//  WidgetDataManager.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/18.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import CoreData

internal class WidgetDataManager {
    static var shared = WidgetDataManager()
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: context)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSManagedObjectContextDidSave, object: context)
    }
    private var objects = [NSManagedObject]()
    private let context = CoreDataStack.persistentContainer.viewContext
    private let entityName = "Idea"

    internal func getAllExistedIdeaData(_ completion: @escaping (Bool,[IdeaItem])->Void){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]
        
        do {
            objects = try CoreDataStack.persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        var ideas = [IdeaItem]()
        for object in objects {
            //Should refresh object, because core data between main app and app extension is in different process , will not update instantly if not refresh.
            CoreDataStack.persistentContainer.viewContext.refresh(object, mergeChanges: true)
            if let date = object.value(forKey: "addingDate") as? Date,
                let header = object.value(forKey: "header") as? String ,
                let isDelete = object.value(forKey: "isDelete") as? Bool,
                let isFinish = object.value(forKey: "isFinish") as? Bool,
                let markColor = object.value(forKey: "markColor") as? UIColor, isDelete == false, isFinish == false{
                    ideas.append(IdeaItem(header: header, markColor: markColor, addingDate: date))
            }
        }
        completion(true, ideas)

    }
    
    internal func deleteOneIdeaDataToTrash(ideaData: IdeaItem, _ completion: ((Bool)->Void)?=nil){
        var findObject = false
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(true, forKey: "isDelete")
            CoreDataStack.persistentContainer.viewContext.refresh(object, mergeChanges: true)
            managedContextSave()
            findObject = true
        }
        completion?(findObject)
    
    }
    
    private func managedContextSave(){
        let context = CoreDataStack.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    @objc private func contextDidSave(notification: NSNotification){
        guard let userInfo = notification.userInfo else {
            return
        }
        
        let userDefaults = UserDefaults(suiteName: "group.catchidea.linshiwei")
        
        var notificationData = [AnyHashable : Any]()
        
        for (key, value) in userInfo {
            guard let value = value as? NSSet else {
                continue
            }
            
            var uriRepresentations = [AnyObject]()
            
            for element in value {
                guard let managedObject = element as? NSManagedObject else {
                    continue
                }
                
                uriRepresentations.append(managedObject.objectID.uriRepresentation() as AnyObject)
            }
            
            notificationData[key] = uriRepresentations
        }
        
        var notificationDatas = [AnyObject]()
        
        if let data = userDefaults!.object(forKey: widgetCoreDataChangeKey) as? Data,
            let existingNotificationDatas = NSKeyedUnarchiver.unarchiveObject(with: data) as? [AnyObject] {
            notificationDatas.append(contentsOf: existingNotificationDatas)
        }
        
        notificationDatas.append(notificationData as AnyObject)
        
        let archivedData: Data = NSKeyedArchiver.archivedData(withRootObject: notificationDatas)
        
        userDefaults!.set(archivedData, forKey: widgetCoreDataChangeKey)
        
        userDefaults!.synchronize()
    }
}
