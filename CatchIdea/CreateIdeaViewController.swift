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
        let strings = LocalizationStrings.shared
        titleSectionView.sectionTitle = strings.createIdeaTitleSectionTitle
        markColorSectionView.sectionTitle = strings.createIdeaMarkColorSectionTitle
        contentSectionView.sectionTitle = strings.createIdeaContentSectionTitle
        notificationSectionView.sectionTitle = strings.createIdeaNotificationSectionTitle   
        
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
     
        ViewControllermanager.shared.createVC = nil
        super.viewWillDisappear(animated)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        ideaDataSheetView.resignSubviewsFirstResponder()
        super.dismiss(animated: flag, completion: completion)
    }
    
    @IBAction func tapToResignFirstResponse(_ sender: UITapGestureRecognizer) {
        ideaDataSheetView.resignSubviewsFirstResponder()
    }

    @IBAction func saveIdea(_ sender: UIBarButtonItem) {
        ideaDataSheetView.saveIdea()
        if let mainVC = transitioningDelegate as? MainViewController {
            mainVC.dimDismissAnimationController.dimCenter = CGPoint(x: windowBounds.width-22, y: 22)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancleCreateIdea(_ sender: UIBarButtonItem) {
        if let mainVC = transitioningDelegate as? MainViewController {
            mainVC.dimDismissAnimationController.dimCenter = CGPoint(x: 22, y: 22)
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
