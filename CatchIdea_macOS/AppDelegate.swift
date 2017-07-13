//
//  AppDelegate.swift
//  CatchIdea_macOS
//
//  Created by Lin,Shiwei on 2017/6/25.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {

        guard let application = aNotification.object as? NSApplication else{
            return
        }
        let myType = NSRemoteNotificationType.badge
        application.registerForRemoteNotifications(matching: myType)
//        NSRemoteNotificationType myTypes =
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String : Any]) {
        let cloudKitNotificaton = CKNotification(fromRemoteNotificationDictionary: userInfo)
        guard cloudKitNotificaton.notificationType == .query, let notif = cloudKitNotificaton as? CKQueryNotification else {
            return
        }

        guard let key = notif.alertLocalizationKey,let recordID = notif.recordID else {
            return
        }
        switch key {
        case ICloudDashBoardKey.notificationCreate:
            
            ICloudManager.shared().getIdeaItemDictionary(with: recordID, withCompletion: {(dic,success) in
                CoreDataManger.shared().createNewObject(withKeyValue: dic)

            })
        case ICloudDashBoardKey.notificationDelete:
            CoreDataManger.shared().deleteObject(withUUID: recordID.recordName)
            
            break
        case ICloudDashBoardKey.notificationUpdate:
            ICloudManager.shared().getIdeaItemDictionary(with: recordID, withCompletion: {(dic,success) in
                guard ((dic != nil)&&success) else {return}
                CoreDataManger.shared().reviseObject(withUUID: recordID.recordName, andKeyValue: dic)
                
            })
            break
        default:
            break;
        }
        
//        let context = self.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "IdeaItemObject", in: context)
//        let ideaObj = NSManagedObject(entity: entity!, insertInto: context)
//        saveAction(nil)
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CatchIdea_macOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared().presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplicationTerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == NSAlertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

