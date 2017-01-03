//
//  MainViewController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MainViewController: UIViewController {

    fileprivate let ideaDataManager = DataManager.shared
    
    private var existedIdeas = [IdeaData]()
    
    internal let dimPresentAnimationController = DimPresentAnimationController()
    internal let dimDismissAnimationController = DimDismissAnimationController()

    @IBOutlet weak var ideaListTableView: MainVCTableView!
    @IBOutlet weak var tableViewBottomSpace: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ideaDataManager.getAllIdeaData(type:.existed){[unowned self](success,ideas) in
            if (success&&(ideas != nil)){
                self.ideaListTableView.ideaData = ideas!
                self.ideaListTableView.reloadData()
            }
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let _ = ideaListTableView.resignFirstResponder()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        notificationCenter.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "IdeaCellDetail":
            if let destinationViewController = segue.destination as? CreateIdeaViewController,let cell = sender as? IdeaListTableViewCell {
                destinationViewController.originIdeaData = cell.ideaData
                destinationViewController.transitioningDelegate = self
                if let touchCenter = cell.touchPointInWindow {
                    dimPresentAnimationController.dimCenter = touchCenter
                }
            }
        case "PullToCreateIdea":
            if let destinationViewController = segue.destination as? CreateIdeaViewController {
                destinationViewController.transitioningDelegate = self
                dimPresentAnimationController.dimCenter = CGPoint(x: windowBounds.width/2, y: 88)
            }
        case "ShowTrash":
            if let destinationViewController = segue.destination as? TrashViewController {
                destinationViewController.transitioningDelegate = self
            }
        default:
            break
        }
    }
    
    @IBAction func tapToResignFirstResponder(_ sender: UITapGestureRecognizer) {
        
        if let indexPath = ideaListTableView.indexPathForRow(at: sender.location(in: ideaListTableView)), let cell = ideaListTableView.cellForRow(at: indexPath) as? IdeaListTableViewCell{
            cell.touchPointInWindow = sender.location(in: nil)
            performSegue(withIdentifier: "IdeaCellDetail", sender: cell)
        }else{
            let _ = ideaListTableView.resignFirstResponder()
        }
    }
    
    internal func keyboardDidShow(_ notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else{return}
        let keyboardRectInView = self.view.convert(keyboardRect, from: nil)
        
        tableViewBottomSpace.constant = keyboardRectInView.height
        
        self.view.layoutIfNeeded()
    }
    
    internal func keyboardWillHide(_ notification: Notification) {
        tableViewBottomSpace.constant = 0
        self.view.layoutIfNeeded()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.borderWidth = 0
    }
    //MARK ScrollView delegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let refreshControl = scrollView.refreshControl,refreshControl.isRefreshing == true {
            performSegue(withIdentifier: "PullToCreateIdea", sender: nil)
            refreshControl.endRefreshing()
        }
        
        let yOffset = scrollView.contentOffset.y
        let xOffset = scrollView.contentOffset.x
        if yOffset > 0 && yOffset < 22 {
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        }else if yOffset >= 22 && yOffset < 44 {
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 44), animated: true)
        }else if yOffset > 44 && yOffset < 66 {
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 44), animated: true)
        }else if yOffset >= 66 && yOffset < 88 {
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 88), animated: true)
        }
        
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollview offset \(scrollView.contentOffset.y)")
//    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let table = tableView as? MainVCTableView else {
            return 0
        }
        return table.filteredIdeaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdeaListTableViewCell", for: indexPath) as! IdeaListTableViewCell
        if let table = tableView as? MainVCTableView {
            cell.ideaData = table.filteredIdeaData[indexPath.row]
            cell.delegate = table
        }     
        return cell
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch presented {
        case is TrashViewController:
            let revealPresentAnimationController = RevealPresentAnimationController()
            return revealPresentAnimationController
        case is CreateIdeaViewController:
            return dimPresentAnimationController
        default:
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissed {
        case is TrashViewController:
            let revealDismissAnimationController = RevealDismissAnimationController()
            return revealDismissAnimationController
        case is CreateIdeaViewController:
            return dimDismissAnimationController
        default:
            return nil
        }
        
    }
}
