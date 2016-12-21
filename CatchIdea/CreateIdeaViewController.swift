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
    
    @IBOutlet weak var ideaDataSheetView: IdeaDataSheetView!
    
    private let dataManager = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let idea = originIdeaData {
            ideaDataSheetView.idea = idea
        }

    }

    @IBAction func tapToResignFirstResponse(_ sender: UITapGestureRecognizer) {
        ideaDataSheetView.resignSubviewsFirstResponder()
    }
    
    @IBAction func okToCreateIdea(_ sender: UIButton) {
        ideaDataSheetView.saveIdea()
        cancleCreateIdea(sender)

    }
    
    @IBAction func cancleCreateIdea(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
}
