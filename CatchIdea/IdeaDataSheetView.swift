//
//  IdeaDataSheetView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/21.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class IdeaDataSheetView: UIView {

    fileprivate var headerTextField: UITextField!
    private var contentTextView: ContextTextView!
    dynamic private var reminderSwitch: UISwitch!
    private var markColorView: MarkColorsView!
    private var reminderIntervalSlider: UISlider!
    private var notificationIntervalLabel: UILabel!
    private let dataManager = DataManager.shared
    
    private var notificationInterval: TimeInterval = leastNotificationInterval {
        didSet{
            let minutes = Int(floor(notificationInterval/60))
            if minutes < 60 {
                notificationIntervalLabel.text = "\(minutes)"+LocalizationStrings.shared.createIdeaNotificationMinSuffix
            }else{
                let hours = minutes/60
                notificationIntervalLabel.text = "\(hours)"+LocalizationStrings.shared.createIdeaNotificationHourSuffix
            }
        }
    }
    
    internal var idea : IdeaData?{
        didSet{
            guard let idea = idea else {return}
            headerTextField.text = idea.header

//            reminderSwitch.isOn = (idea.notificationDate != nil) ? true : false
            reminderSwitch.isOn = false
            markColorView.currentSelectedColor = idea.markColor()
            
            if idea.content != "" {
                contentTextView.text = idea.content
                contentTextView.textColor = UIColor.black
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        headerTextField = viewWithTag(1) as! UITextField
        contentTextView = viewWithTag(2) as! ContextTextView
        markColorView = viewWithTag(3) as! MarkColorsView
        reminderSwitch = viewWithTag(4) as! UISwitch
        reminderIntervalSlider = viewWithTag(5) as! UISlider
        notificationIntervalLabel = viewWithTag(6) as! UILabel
        
        headerTextField.borderStyle = .none
        reminderIntervalSlider.addTarget(self, action: #selector(sliderDidChangeValue(sender:)), for: .valueChanged)
        reminderIntervalSlider.isEnabled = reminderSwitch.isOn
        
        reminderSwitch.addTarget(self, action: #selector(switchDidChangeValue(sender:)), for: .valueChanged)
    }
    
    internal func saveIdea(){
        if let header = headerTextField.text, header != "" {
            if let idea = idea {
                dataManager.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: idea)
            }
            //记得修改正确的时间间隔
            let notificationDate = reminderSwitch.isOn ? Date(timeIntervalSinceNow: notificationInterval) : nil
            let ideaData = IdeaData(addingDate: Date(), header: header, content: contentTextView.contentText,markColor: markColorView.currentSelectedColor, notificationDate: notificationDate)
            dataManager.saveOneIdeaData(ideaData: ideaData)
        }
    }
    
    internal func resignSubviewsFirstResponder() {
        headerTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
    
    internal func textFieldBecomeFirstResponder() {
        headerTextField.becomeFirstResponder()
    }
    
    @objc private func switchDidChangeValue(sender: UISwitch){
        reminderIntervalSlider.isEnabled = sender.isOn
    }
    
    @objc private func sliderDidChangeValue(sender: UISlider){
        notificationInterval = TimeInterval((reminderIntervalSlider.value*294)*(reminderIntervalSlider.value*294)) + leastNotificationInterval

    }

}

extension IdeaDataSheetView: UITextFieldDelegate{
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        headerTextField.resignFirstResponder()
        return true
    }
}

extension IdeaDataSheetView: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let textView = textView as? ContextTextView else {return}
        if textView.text == textView.placeholder {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let textView = textView as? ContextTextView else {return}
        if textView.text == "" {
            textView.text = textView.placeholder
            textView.textColor = UIColor.lightGray
        }
    }
}
