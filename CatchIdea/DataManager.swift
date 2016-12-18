//
//  DataManager.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit
import CoreData

internal enum IdeaDataType {
    case existed,deleted
}

internal final class DataManager {
    private let entityName = "Idea"
    
    static let shared = DataManager()
    private init(){
    }
    
    private var objects = [NSManagedObject]()
    
    //MARK: Public API
    internal func getAllIdeaData(type: IdeaDataType, _ completion: @escaping (Bool,[IdeaData]?)->Void) {
        getIdeaDataObjects{[unowned self] success in
            switch type {
            case .existed:
                self.getIdeaData(filter: {$0.value(forKey: "isDelete") as? Bool == false}, completion)
            case .deleted:
                self.getIdeaData(filter: {$0.value(forKey: "isDelete") as? Bool == true}, completion)
            }
        }
    }
    
    private func getIdeaData(filter: ((NSManagedObject)->Bool), _ completion: @escaping (Bool,[IdeaData]?)->Void) {
        var ideas = [IdeaData]()
        for object in objects{
            if filter(object) {
                if let addingDate = object.value(forKey: "addingDate") as? Date,
                    let header = object.value(forKey: "header") as? String ,
                    let content = object.value(forKey: "content") as? String,
                    let isFinish = object.value(forKey: "isFinish") as? Bool,
                    let isDelete = object.value(forKey: "isDelete") as? Bool {
                    ideas.append(IdeaData(addingDate: addingDate, header: header, content: content,isFinish: isFinish,isDelete: isDelete))
                }
            }
        }
        completion(true,ideas)
    }
    
    internal func deleteOneIdeaData(type: IdeaDataType, ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        switch type {
        case .existed:
            deleteOneExistedIdeaData(ideaData: ideaData, completion)
        case .deleted:
            deleteOneDeletedIdeaData(ideaData: ideaData, completion)
        }
    }
    
    internal func finishOneIdeaData(ideaData: IdeaData, _ completion:((Bool)->Void)?=nil){
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(true, forKey: "isFinish")
        }
        deleteOneExistedIdeaData(ideaData: ideaData, completion)
    }
    //MARK: Private help func
    
    private func deleteOneDeletedIdeaData(ideaData: IdeaData, _ completion: ((Bool)->Void)?=nil){
        assert(ideaData.isDelete == true)
        let managedContext = getManagedContext()
        let count = objects.count
        for (index,object) in objects.enumerated() where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            assert(object.value(forKey: "isDelete") as! Bool == true)
            managedContext.delete(object)
            managedContextSave()
            objects.remove(at: index)
        }
        assert(objects.count == count - 1)
        completion?(true)
    }
    
    private func deleteOneExistedIdeaData(ideaData: IdeaData, _ completion: ((Bool)->Void)?=nil){
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            object.setValue(true, forKey: "isDelete")
            managedContextSave()
        }
        completion?(true)
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
                saveMockIdeaData(ideas: mockIdeaData(),completion)
            }
        }else{
            completion(true)
        }
    }
  
    private func saveMockIdeaData(ideas: [IdeaData],_ completion: @escaping ((Bool)->Void)) {
        DispatchQueue.global().async {[unowned self] in
            let managedContext = self.getManagedContext()
            let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: managedContext)
            for idea in ideas {
                
                let ideaObject = NSManagedObject(entity: entity!, insertInto: managedContext)
                ideaObject.setValue(idea.addingDate, forKey: "addingDate")
                ideaObject.setValue(idea.header, forKey: "header")
                ideaObject.setValue(idea.content, forKey: "content")
                ideaObject.setValue(idea.isDelete, forKey: "isDelete")
                ideaObject.setValue(idea.isFinish, forKey: "isFinish")
                self.objects.append(ideaObject)
            }
            self.managedContextSave()
            completion(true)
        }
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
    
    private func getManagedContext()->NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
    private func managedContextSave(){
        let managedContext = getManagedContext()
        do{
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
