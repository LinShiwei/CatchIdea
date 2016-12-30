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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    //MARK ScrollView delegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let refreshControl = scrollView.refreshControl,refreshControl.isRefreshing == true {
            performSegue(withIdentifier: "PullToCreateIdea", sender: nil)
            refreshControl.endRefreshing()
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

extension MainViewController: UISearchBarDelegate {
    
}
