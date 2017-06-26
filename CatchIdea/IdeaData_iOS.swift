//
//  IdeaData_iOS.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

extension IdeaData :MarkColor {
    typealias Color = UIColor
    
    func markColor(){
        
        return UIColor.red
    }
    
    func setMarkColor(_ markColor: UIColor) {
        self.markColor = markColor
    }
}
