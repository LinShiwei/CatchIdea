//
//  FilterManager.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/29.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class FilterManager: NSObject {
    static let shared = FilterManager()
    
    private override init() {
        super.init()
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        
    }
}

extension FilterManager: ColorSelectionDelegate {
    func didSelectColor(_ color: Color) {
        
    }
}

extension FilterManager: NSSearchFieldDelegate{
    
}
