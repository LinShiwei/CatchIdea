//
//  TrashViewController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/18.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class TrashViewController: UIViewController {
    
    fileprivate var ideaDataManager = DataManager.shared
    
    @IBOutlet weak var trashTableView: TrashTableView!
    @IBOutlet weak var backToMainVCButton: UIBarButtonItem!
    
    @IBOutlet weak var tableViewBottomSpace: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ideaDataManager.getAllIdeaData(type:.deleted){[unowned self](success,ideas) in
            if (success&&(ideas != nil)){
                self.trashTableView.ideaData = ideas!
                DispatchQueue.main.async {
                    self.trashTableView.reloadData()
                }
                
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
            if let hasShownMainVCGuide = userDefault.value(forKey: "HasShownTrashVCGuide") as? Bool, hasShownMainVCGuide == true{
                //comment out the following line when use
//                userDefault.set(false, forKey: "HasShownTrashVCGuide")
            }else{
                performSegue(withIdentifier: "ShowGuide", sender: nil)
                userDefault.set(true, forKey: "HasShownTrashVCGuide")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let _ = trashTableView.resignFirstResponder()
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        notificationCenter.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "ShowGuide":
            if let destinationViewController = segue.destination as? GuideViewController {
                if let snapshot = view.snapshotView(afterScreenUpdates: true) {
                    destinationViewController.snapshot = snapshot
                    let imageView = UIImageView(image: LocalizationStrings.shared.trashGuideImage)
                    imageView.center = CGPoint(x: windowBounds.width/2, y: imageView.frame.height/2+152)
                    destinationViewController.containerView.addSubview(imageView)
                }
            }
            break
        default:
            break
        }
    }
    
    @IBAction func clearTrashForever(_ sender: Any) {
        guard trashTableView.numberOfRows(inSection: 0) > 0 else {return}
        let strings = LocalizationStrings.shared
        let alert = UIAlertController(title: strings.trashClearMessageTitle, message: strings.trashClearMessageContent, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: strings.okString, style: .default,handler: { (action:UIAlertAction) -> Void in
            self.ideaDataManager.deleteAllIdeaDataInTrash(){[unowned self] success in
                if success {
                    self.trashTableView.ideaData.removeAll()
                    self.trashTableView.reloadData()
                }
            }
        })
        let cancelAction = UIAlertAction(title: strings.cancleString, style: .default) { (action: UIAlertAction) -> Void in }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissTrashVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToResignFirstResponder(_ sender: Any) {
        let _ = trashTableView.resignFirstResponder()
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

extension TrashViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.borderWidth = 0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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

extension TrashViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let table = tableView as? TrashTableView else {
            return 0
        }
        return table.filteredIdeaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrashTableViewCell", for: indexPath) as! TrashTableViewCell
        if let table = tableView as? TrashTableView {
            cell.delegate = table
            cell.ideaData = table.filteredIdeaData[indexPath.row]
        }
        return cell
    }
}
