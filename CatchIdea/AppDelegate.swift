//
//  AppDelegate.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//    override class func initialize() -> Void {
//        //enable preview mode
//                iRate.sharedInstance().previewMode = true
//    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        LocalNotificationManager.shared.requestAuthorization()  
        return true
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let siren = Siren.sharedInstance
        siren.alertType = .skip
        siren.checkVersion(checkType: .daily)
        
        application.statusBarStyle = .lightContent
        
//        completeIAPTransactions()
        AppStoreManager.shared.completeTransactions()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        mergeChangesFromWidget()
        LocalNotificationManager.shared.checkoutDeliveredNotification()
        if let mainVC = window?.rootViewController as? MainViewController {
            mainVC.ideaListTableView.checkoutCellsNotification()
        }

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveAction(nil)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString == "catchIdeaWidget://main" {
            
        }
        return true
    }
    
    // MARK: Core Data
    lazy var persistentContainer = CoreDataStack.persistentContainer
    
    // MARK: - Core Data Saving support
    
    func saveAction (_ sender: AnyObject?) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    private func mergeChangesFromWidget() {
        let userDefaults = UserDefaults(suiteName: "group.catchidea.linshiwei")
        guard let data = userDefaults!.object(forKey: widgetCoreDataChangeKey) as? Data else {
            return
        }
        guard let notificationsArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [AnyObject] else {
            return
        }
        self.persistentContainer.viewContext.perform {[unowned self] in
            for notificationData in notificationsArray {
                guard let notificationData = notificationData as? [NSObject : AnyObject] else {
                    continue
                }
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: notificationData, into: [self.persistentContainer.viewContext])
            }
            self.refreshViewController()
        }
        
        defer {
            userDefaults!.removeObject(forKey: widgetCoreDataChangeKey)
            userDefaults!.synchronize()
        }
    }
    
    private func refreshViewController(){
        var topViewController = self.window?.rootViewController
        guard topViewController != nil else {
            return
        }
        while (topViewController!.presentedViewController != nil) {
            topViewController = topViewController!.presentedViewController
        }
        if topViewController is MainViewController || topViewController is TrashViewController {
            topViewController?.viewWillAppear(true)
        }
    }
    
//    private func completeIAPTransactions() {
//        
//        SwiftyStoreKit.completeTransactions(atomically: true) { products in
//            
//            for product in products {
//                
//                if product.transaction.transactionState == .purchased || product.transaction.transactionState == .restored {
//                    
//                    if product.needsFinishTransaction {
//                        // Deliver content from server, then:
//                        SwiftyStoreKit.finishTransaction(product.transaction)
//                    }
//                    print("purchased: \(product.productId)")
//                }
//            }
//        }
//    }
}

