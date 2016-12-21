//
//  IdeaDataSheetView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/21.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class IdeaDataSheetView: UIView {

    private var headerTextField : UITextField!
    private var contentTextView : UITextView!
    private var reminderSwitch : UISwitch!
    
    private let dataManager = DataManager.shared

    internal var idea : IdeaData?{
        didSet{
            guard let idea = idea else {return}
            headerTextField.text = idea.header
            contentTextView.text = idea.content
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        headerTextField = viewWithTag(1) as! UITextField
        contentTextView = viewWithTag(2) as! UITextView
        reminderSwitch = viewWithTag(3) as! UISwitch

        
    }

    internal func saveIdea(){
        if let header = headerTextField.text {
            if let idea = idea {
                dataManager.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: idea)
            }
            let ideaData = IdeaData(addingDate: Date(), header: header, content: contentTextView.text)
            dataManager.saveOneIdeaData(ideaData: ideaData)
        }
    }
    
    internal func resignSubviewsFirstResponder() {
        headerTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
}
