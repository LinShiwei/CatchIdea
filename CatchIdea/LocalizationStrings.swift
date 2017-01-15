//
//  LocalizationStrings.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/15.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation

internal class LocalizationStrings {
    static let shared = LocalizationStrings()
    internal let mainTableEmptyString: String
    internal let trashTableEmptyString: String
    
    internal let createIdeaTitleSectionTitle: String
    internal let createIdeaMarkColorSectionTitle: String
    internal let createIdeaContentSectionTitle: String
    internal let createIdeaNotificationSectionTitle: String
    internal let createIdeaNotificationMinSuffix: String
    internal let createIdeaNotificationHourSuffix: String
    
    internal let pullIndicationText: String
    internal let releaseIndicationText: String
    
    internal let searchBarCancleButtonTitle: String
    

    private init(){
        
        if isLanguageChineseSimple {
            mainTableEmptyString = "下拉记录新的灵感"
            trashTableEmptyString = "这里什么都没有"
            
            createIdeaTitleSectionTitle = "主题"
            createIdeaMarkColorSectionTitle = "标记颜色"
            createIdeaContentSectionTitle = "内容"
            createIdeaNotificationSectionTitle = "推送通知"
            createIdeaNotificationMinSuffix = " 分钟后"
            createIdeaNotificationHourSuffix = " 小时后"
            
            
            pullIndicationText = "下拉记录新的灵感"
            releaseIndicationText = "释放记录新的灵感"
            
            searchBarCancleButtonTitle = "取消"
            
        }else{
            mainTableEmptyString = "Drag down to create new idea."
            trashTableEmptyString = "There is nothing."
            
            createIdeaTitleSectionTitle = "Title"
            createIdeaMarkColorSectionTitle = "MarkColor"
            createIdeaContentSectionTitle = "Content"
            createIdeaNotificationSectionTitle = "Notification"
            createIdeaNotificationMinSuffix = " mins later"
            createIdeaNotificationHourSuffix = " hour(s) later"
            
            pullIndicationText = "Pull to create a new idea."
            releaseIndicationText = "Release to create a new idea."
            
            searchBarCancleButtonTitle = "Cancle"
        }
    
    
    }
    
}
