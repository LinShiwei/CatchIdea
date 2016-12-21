//
//  CreateIdeaViewController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/20.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

//internal 

internal class CreateIdeaViewController: UIViewController {

    internal var originIdeaData: IdeaData?
    
    @IBOutlet weak var ideaHeaderTextField: UITextField!
    @IBOutlet weak var ideaContentTextView: UITextView!
    
    private let dataManager = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let idea = originIdeaData {
            ideaHeaderTextField.text = idea.header
            ideaContentTextView.text = idea.content
        }

    }

    @IBAction func tapToResignFirstResponse(_ sender: UITapGestureRecognizer) {
        ideaHeaderTextField.resignFirstResponder()
        ideaContentTextView.resignFirstResponder()
    }
    
    @IBAction func okToCreateIdea(_ sender: UIButton) {
        if let idea = originIdeaData {
            dataManager.deleteOneIdeaData(type: .existed, ideaData: idea)
        }
        if let header = ideaHeaderTextField.text {
            let ideaData = IdeaData(addingDate: Date(), header: header, content: ideaContentTextView.text)
            dataManager.saveOneIdeaData(ideaData: ideaData)
        }
        cancleCreateIdea(sender)

    }
    
    @IBAction func cancleCreateIdea(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
}
