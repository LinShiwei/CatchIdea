//
//  WidgetLocalizationStrings.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/20.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation

internal class WidgetLocalizationStrings {
    static let shared = WidgetLocalizationStrings()
    private let isLanguageChineseSimple : Bool = {
        if let languageID = Bundle.main.preferredLocalizations.first,languageID.contains("zh-Hans"){
            return true
        }else{
            return false
        }
    }()
    
    internal var defaultCellHeader: String
    
    private init(){
        if isLanguageChineseSimple {
            defaultCellHeader = "记录新的灵感吧"
        }else{
            defaultCellHeader = "Record new inspiration."
        }
    }
}
