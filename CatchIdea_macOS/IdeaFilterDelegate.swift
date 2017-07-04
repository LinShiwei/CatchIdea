//
//  IdeaFilterDelegate.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/4.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation
//Color index 0 stand for clear color. Color index range from 0 to 6.
protocol IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColorIndex index: Int)
}
