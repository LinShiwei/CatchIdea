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
    
    @IBOutlet weak var titleSectionView: CreateIdeaSectionView!
    @IBOutlet weak var markColorSectionView: CreateIdeaSectionView!
    @IBOutlet weak var contentSectionView: CreateIdeaSectionView!
    @IBOutlet weak var notificationSectionView: CreateIdeaSectionView!
    
    @IBOutlet weak var ideaDataSheetView: IdeaDataSheetView!
    
    @IBOutlet weak var scrollViewBottomSpace: NSLayoutConstraint!
    
    private let dataManager = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        titleSectionView.sectionTitle = "Title"
        markColorSectionView.sectionTitle = "Mark Color"
        contentSectionView.sectionTitle = "Content"
        notificationSectionView.sectionTitle = "Notification"
        
        if let idea = originIdeaData {
            ideaDataSheetView.idea = idea
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ideaDataSheetView.textFieldBecomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        notificationCenter.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
        ideaDataSheetView.resignSubviewsFirstResponder()
        
        super.viewWillDisappear(animated)
    }
    
    @IBAction func tapToResignFirstResponse(_ sender: UITapGestureRecognizer) {
        ideaDataSheetView.resignSubviewsFirstResponder()
    }

    @IBAction func saveIdea(_ sender: UIBarButtonItem) {
        ideaDataSheetView.saveIdea()
        cancleCreateIdea(sender)
    }
    
    @IBAction func cancleCreateIdea(_ sender: UIBarButtonItem) {
        if let mainVC = transitioningDelegate as? MainViewController {
            mainVC.dimDismissAnimationController.dimCenter = mainVC.dimPresentAnimationController.dimCenter
        }
        dismiss(animated: true, completion: nil)
    }
    
    internal func keyboardDidShow(_ notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else{return}
        let keyboardRectInView = self.view.convert(keyboardRect, from: nil)
        
        scrollViewBottomSpace.constant = keyboardRectInView.height
        
        self.view.layoutIfNeeded()
    }
    
    internal func keyboardWillHide(_ notification: Notification) {
        scrollViewBottomSpace.constant = 0
        self.view.layoutIfNeeded()
    }
}
