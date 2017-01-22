//
//  Define.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal let windowBounds = UIScreen.main.bounds

internal let leastNotificationInterval: TimeInterval = 300

internal let isLanguageChineseSimple : Bool = {
    if let languageID = Bundle.main.preferredLocalizations.first,languageID.contains("zh-Hans"){
        return true
    }else{
        return false
    }
}()

internal let widgetCoreDataChangeKey = "WidgetObjectChangesKey"
