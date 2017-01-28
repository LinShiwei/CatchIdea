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

    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var ideaListTableView: MainVCTableView!
    @IBOutlet weak var tableViewBottomSpace: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        ideaListTableView.addPullRefresh{ [weak self] in
            
            if ViewControllermanager.shared.createVC == nil {
                self?.performSegue(withIdentifier: "PullToCreateIdea", sender: nil)
                
            }else{
                
            }
           
            self?.ideaListTableView.stopPullRefreshEver()
      
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ideaDataManager.getAllIdeaData(type:.all){[unowned self](success,ideas) in
            if (success&&(ideas != nil)){
                self.trashButton.image = #imageLiteral(resourceName: "Delete")
                var existedIdeas = [IdeaData]()
                for idea in ideas! {
                    if idea.isDelete == true {
                        self.trashButton.image = #imageLiteral(resourceName: "DeleteFilled")
                    }else{
                        existedIdeas.append(idea)
                    }
                }
                self.ideaListTableView.ideaData = existedIdeas
                self.ideaListTableView.reloadData()
            }
        }

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defer {
            let userDefault = UserDefaults.standard
            if let hasShownMainVCGuide = userDefault.value(forKey: "HasShownMainVCGuide") as? Bool, hasShownMainVCGuide == true{
                //comment out the following line when use
//                userDefault.set(false, forKey: "HasShownMainVCGuide")
            }else{
                performSegue(withIdentifier: "ShowGuide", sender: nil)
                userDefault.set(true, forKey: "HasShownMainVCGuide")
            }
        }
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
                ViewControllermanager.shared.createVC = destinationViewController
                destinationViewController.transitioningDelegate = self
                dimPresentAnimationController.dimCenter = CGPoint(x: windowBounds.width/2, y: 88)
            }
        case "ShowTrash":
            if let destinationViewController = segue.destination as? TrashViewController {
                destinationViewController.transitioningDelegate = self
            }
        case "ShowGuide":
            if let destinationViewController = segue.destination as? GuideViewController {
                if let snapshot = view.snapshotView(afterScreenUpdates: true) {
                    destinationViewController.snapshot = snapshot
                    let imageView = UIImageView(image: LocalizationStrings.shared.mainGuideImage)
                    imageView.center = CGPoint(x: windowBounds.width/2, y: imageView.frame.height/2+152)
                    destinationViewController.containerView.addSubview(imageView)
                }
            }
            break
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
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: { [unowned self] Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    internal func keyboardWillHide(_ notification: Notification) {
        tableViewBottomSpace.constant = 0
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: { [unowned self] Void in
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.borderWidth = 0
        if let ideaCell = cell as? IdeaListTableViewCell {
            ideaCell.checkoutCellNotification()
        }
    }
    //MARK ScrollView delegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
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
            if indexPath.row == 0{
                
            }
            cell.ideaData = table.filteredIdeaData[indexPath.row]
            cell.delegate = self
        }     
        return cell
    }
}

extension MainViewController: IdeaCellManagerDelegate{
    func deleteIdea(sender: UITableViewCell){
        guard let indexPath = ideaListTableView.indexPath(for: sender) else {return}
        DataManager.shared.deleteOneIdeaData(deleteStyle: .moveToTrash, ideaData: ideaListTableView.ideaData[indexPath.row])
        //remove ideaData will trigger didSet to reset filterIdeaData, so copy filterIdeaData for later use
        var tempFilterIdeaData = ideaListTableView.filteredIdeaData
        for index in 0...ideaListTableView.ideaData.count-1 {
            if ideaListTableView.ideaData[index] == ideaListTableView.filteredIdeaData[indexPath.row]{
                ideaListTableView.ideaData.remove(at: index)
                break
            }
        }
        tempFilterIdeaData.remove(at: indexPath.row)
        ideaListTableView.filteredIdeaData = tempFilterIdeaData
        ideaListTableView.beginUpdates()
        ideaListTableView.deleteRows(at: [indexPath], with: .left)
        ideaListTableView.endUpdates()
        
        trashButton.image = #imageLiteral(resourceName: "DeleteFilled")
    }
    
    func finishIdea(sender: UITableViewCell){
        guard let indexPath = ideaListTableView.indexPath(for: sender) else {return}
        DataManager.shared.finishOneIdeaData(ideaData: ideaListTableView.ideaData[indexPath.row])
        var tempFilterIdeaData = ideaListTableView.filteredIdeaData
        for index in 0...ideaListTableView.ideaData.count-1 {
            if ideaListTableView.ideaData[index] == ideaListTableView.filteredIdeaData[indexPath.row]{
                ideaListTableView.ideaData.remove(at: index)
                break
            }
        }
        tempFilterIdeaData.remove(at: indexPath.row)
        ideaListTableView.filteredIdeaData = tempFilterIdeaData
        ideaListTableView.beginUpdates()
        ideaListTableView.deleteRows(at: [indexPath], with: .right)
        ideaListTableView.endUpdates()
        
        trashButton.image = #imageLiteral(resourceName: "DeleteFilled")
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
