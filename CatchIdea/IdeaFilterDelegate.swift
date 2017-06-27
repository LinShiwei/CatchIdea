//
//  IdeaFilterDelegate.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation

protocol IdeaFilterDelegate {
    func filterIdea(withSearchText text: String, andMarkColor color: Color)
}
