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
    
    internal let mainTableDefaultCellTitle: String
    
    internal let createIdeaTitleSectionTitle: String
    internal let createIdeaMarkColorSectionTitle: String
    internal let createIdeaContentSectionTitle: String
    internal let createIdeaNotificationSectionTitle: String
    internal let createIdeaContextViewPlaceholder: String
    internal let createIdeaNotificationMinSuffix: String
    internal let createIdeaNotificationHourSuffix: String
    
    internal let pullIndicationText: String
    internal let releaseIndicationText: String
    
    internal let trashClearMessageTitle: String
    internal let trashClearMessageContent: String

    internal let okString: String
    internal let cancleString: String
    
    internal let mainGuideImage: UIImage
    internal let trashGuideImage: UIImage
    
    private init(){
        
        if isLanguageChineseSimple {
            mainTableEmptyString = "下拉记录新的灵感"
            trashTableEmptyString = "纸篓清空啦"
            
            mainTableDefaultCellTitle = "滑动删除"
            
            createIdeaTitleSectionTitle = "主题"
            createIdeaMarkColorSectionTitle = "标记颜色"
            createIdeaContentSectionTitle = "内容"
            createIdeaNotificationSectionTitle = "推送通知"
            createIdeaContextViewPlaceholder = "详细内容..."
            createIdeaNotificationMinSuffix = " 分钟后"
            createIdeaNotificationHourSuffix = " 小时后"
            
            
            pullIndicationText = "下拉记录新的灵感"
            releaseIndicationText = "释放记录新的灵感"
            
            trashClearMessageTitle = "清空纸篓"
            trashClearMessageContent = "要清空纸篓吗？此操作不可恢复。"
            
            okString = "好"
            cancleString = "取消"
            
            mainGuideImage = #imageLiteral(resourceName: "MainGuide_cn")
            trashGuideImage = #imageLiteral(resourceName: "TrashGuide_cn")
            
        }else{
            mainTableEmptyString = "Drag down to create new idea."
            trashTableEmptyString = "Trash is empty."
            
            mainTableDefaultCellTitle = "Swipe to delete."
            
            createIdeaTitleSectionTitle = "Title"
            createIdeaMarkColorSectionTitle = "MarkColor"
            createIdeaContentSectionTitle = "Content"
            createIdeaNotificationSectionTitle = "Notification"
            createIdeaContextViewPlaceholder = "Write down your idea's content here."
            createIdeaNotificationMinSuffix = " mins later"
            createIdeaNotificationHourSuffix = " hour(s) later"
            
            pullIndicationText = "Pull to create a new idea."
            releaseIndicationText = "Release to create a new idea."
            
            trashClearMessageTitle = "Clear Trash"
            trashClearMessageContent = "Delete all ideas forever?"
            
            okString = "OK"
            cancleString = "Cancle"
            
            mainGuideImage = #imageLiteral(resourceName: "MainGuide")
            trashGuideImage = #imageLiteral(resourceName: "TrashGuide") 
        }
    
    
    }
    
}
