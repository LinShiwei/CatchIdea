//
//  LocalNotificationManager.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

internal class LocalNotificationManager: NSObject {
    static let shared = LocalNotificationManager()
//    dynamic internal var currentNotificationIdentifier: String = ""
//    //注意：目前这是中国地区的日历，但是日历并不影响时区！
//    private let calendar = Calendar(identifier: .republicOfChina)
//    private let notificationCenter = UNUserNotificationCenter.current()
//    
    private override init(){
        super.init()
//        notificationCenter.delegate = self
        
    }
    
    internal func requestAuthorization(){
//        notificationCenter.requestAuthorization(options: [.alert, .sound]){ (granted, error) in
//            if(granted&&error == nil){
//                
//            }else{
//                
//            }
//        }
    }
    
    internal func createNewNotification(withIdeaData ideaData: IdeaData){
//        guard let notificationDate = ideaData.notificationDate else {return}
//        
//        let content = UNMutableNotificationContent()
//        content.title = NSString.localizedUserNotificationString(forKey: ideaData.header, arguments: nil)
//        content.body = NSString.localizedUserNotificationString(forKey: ideaData.content == "" ? " ":ideaData.content, arguments: nil)
//        //使用当地时区配置触发时间
//        //        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents(in: TimeZone.current, from: notificationDate), repeats: false)
//        let interval = notificationDate.timeIntervalSince(Date())
//        guard interval > 0 else{return}
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: ideaData.identifier, content: content, trigger: trigger)
//        
//        notificationCenter.add(request){(error) in
//            if let _ = error {
//                assertionFailure()
//            }
//        }
    }
    
    internal func deletePendingNotification(withIdeaData ideaData: IdeaData){
//        notificationCenter.getPendingNotificationRequests(){[unowned self] requests in
//            for request in requests {
//                if request.identifier == ideaData.identifier {
//                    self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [ideaData.identifier])
//                }
//            }
//        }
//        //        notificationCenter.removePendingNotificationRequests(withIdentifiers: [ideaData.identifier])
    }
    
    internal func checkoutDeliveredNotification(){
//        notificationCenter.getDeliveredNotifications(){[unowned self] notifications in
//            for notification in notifications {
//                self.currentNotificationIdentifier = notification.request.identifier
//            }
//        }
    }
}

