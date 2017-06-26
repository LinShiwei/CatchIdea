//
//  IdeaData.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import Foundation

protocol MarkColor {
    associatedtype Color
    func getMarkColor() -> Color?
    func setMarkColor(_ markColor: Color)
}

internal class IdeaData {
    //These properties should store in CoreData
    internal let addingDate: Date
    internal var content: String
    internal var header: String
    internal var isFinish: Bool
    internal var isDelete: Bool
    internal var markColor: UIColor
    internal var notificationDate: Date?
    //These properties don't need to store
    internal var identifier: String {
        get{
            return addingDate.description
        }
    }
    internal init(addingDate: Date, header: String, content: String="",isFinish: Bool=false, isDelete: Bool=false, markColor: UIColor=Theme.shared.markColors[0], notificationDate: Date?=nil) {
        self.addingDate = addingDate
        self.header = header
        self.content = content
        self.isFinish = isFinish
        self.isDelete = isDelete
        self.markColor = markColor
        self.notificationDate = notificationDate
    }
    
    static func == (left: IdeaData, right: IdeaData)->Bool {
        return left.identifier == right.identifier
    }
}
