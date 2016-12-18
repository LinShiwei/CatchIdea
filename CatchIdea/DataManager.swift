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
    static let shared = DataManager()
    private init(){
        getIdeaDataObjects()
    }
    
    private var objects = [NSManagedObject]()
    
    //MARK: Public API
    internal func getAllIdeaData(type: IdeaDataType, _ completion: @escaping (Bool,[IdeaData]?)->Void) {
        switch type {
        case .existed:
            getIdeaData(filter: {$0.value(forKey: "isDelete") as! Bool == false}, completion)
        case .deleted:
            getIdeaData(filter: {$0.value(forKey: "isDelete") as! Bool == true}, completion)
        }
    }
    
    internal func getIdeaData(filter: ((NSManagedObject)->Bool), _ completion: @escaping (Bool,[IdeaData]?)->Void) {
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
    //MARK: Private help func
    
    private func deleteOneDeletedIdeaData(ideaData: IdeaData, _ completion: ((Bool)->Void)?=nil){
        assert(ideaData.isDelete == true)
        let managedContext = getManagedContext()
        let count = objects.count
        for (index,object) in objects.enumerated() where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            assert(object.value(forKey: "isDelete") as! Bool == true)
            managedContext.delete(object)
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
                completion?(false)
            }
            objects.remove(at: index)
        }
        assert(objects.count == count - 1)
        completion?(true)
    }
    
    private func deleteOneExistedIdeaData(ideaData: IdeaData, _ completion: ((Bool)->Void)?=nil){
        for object in objects where object.value(forKey: "addingDate") as! Date == ideaData.addingDate {
            let managedContext = getManagedContext()
            object.setValue(true, forKey: "isDelete")
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
                completion?(false)
            }
        }
        completion?(true)
    }
    
    private func getIdeaDataObjects(){
        if objects.count == 0 {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Idea")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addingDate", ascending: false)]
            do {
                objects = try getManagedContext().fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            if objects.count > 0 {
                
            }else{
                //当要使用模拟数据的时候，解除下注释
                saveMockIdeaData(ideas: mockIdeaData())
            }
        }
    }
  
    private func saveMockIdeaData(ideas: [IdeaData]) {
        DispatchQueue.main.async {[unowned self] in
            let managedContext = self.getManagedContext()
            let entity = NSEntityDescription.entity(forEntityName: "ExistedIdea", in: managedContext)
            for idea in ideas {
                
                let ideaObject = NSManagedObject(entity: entity!, insertInto: managedContext)
                ideaObject.setValue(idea.addingDate, forKey: "addingDate")
                ideaObject.setValue(idea.header, forKey: "header")
                ideaObject.setValue(idea.content, forKey: "content")
                self.objects.append(ideaObject)
            }
            do {
                try managedContext.save()
            }catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
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
          
}
