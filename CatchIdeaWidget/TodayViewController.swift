//
//  TodayViewController.swift
//  CatchIdeaWidget
//
//  Created by Linsw on 16/12/22.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var widgetTableView: UITableView!
    fileprivate let dataManager = WidgetDataManager.shared
    static fileprivate var ideaItem = [IdeaItem]()
    
    fileprivate var hasItem: Bool {
        get{
            return TodayViewController.ideaItem.count > 0 ? true : false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        dataManager.getAllExistedIdeaData{[unowned self] (success, items) in
            guard success else { return }
            TodayViewController.ideaItem = items
            self.widgetTableView.reloadData()
            if let context = self.extensionContext {
                self.widgetActiveDisplayModeDidChange(context.widgetActiveDisplayMode, withMaximumSize: context.widgetMaximumSize(for: .expanded))
            }
            completionHandler(NCUpdateResult.newData)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            UIView.animate(withDuration: 0.25){[unowned self] in
                self.preferredContentSize = maxSize
                self.view.layoutIfNeeded()
            }
        }else if activeDisplayMode == .expanded {
            
            UIView.animate(withDuration: 0.25){[unowned self] in
                var newHeight = 44 * CGFloat(self.widgetTableView.numberOfRows(inSection: 0))
                print(self.widgetTableView.numberOfRows(inSection: 0))
                print(newHeight)
                newHeight = newHeight > maxSize.height ? maxSize.height : newHeight
                self.preferredContentSize = CGSize(width: 0, height: newHeight)
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func tapToJumpToApp(_ sender: UITapGestureRecognizer) {
        extensionContext?.open(URL(string: "catchIdeaWidget://main")!){ success in
            if !success {
                assertionFailure()
            }
        }
    }
}

extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasItem {
            return TodayViewController.ideaItem.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WidgetTableViewCell", for: indexPath) as! WidgetTableViewCell
        if hasItem {
            cell.markColor = TodayViewController.ideaItem[indexPath.row].markColor
            cell.header = TodayViewController.ideaItem[indexPath.row].header
            cell.deleteButton.isHidden = false
            cell.delegate = self
        }else{
            cell.markColor = UIColor.white
            cell.header = WidgetLocalizationStrings.shared.defaultCellHeader
            cell.deleteButton.isHidden = true
        }
        
        return cell
    }
}

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //custom tableview separator
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 8, y: cell.frame.height-1))
        path.addLine(to: CGPoint(x: cell.frame.width, y: cell.frame.height-1))
        let separatorLayer = CAShapeLayer()
        separatorLayer.backgroundColor = UIColor.darkGray.cgColor
        separatorLayer.path = path.cgPath
        separatorLayer.lineWidth = 1
        separatorLayer.strokeColor = UIColor(white: 0.5, alpha: 1).cgColor
        separatorLayer.lineDashPattern = [2,2]
        separatorLayer.lineDashPhase = 0
        
        cell.layer.addSublayer(separatorLayer)
    }
}

extension TodayViewController: WidgetCellManagerDelegate {
    func deleteCell(sender: UITableViewCell) {
        if let indexPath = widgetTableView.indexPath(for: sender) {
            dataManager.deleteOneIdeaDataToTrash(ideaData: TodayViewController.ideaItem[indexPath.row]){ success in
                if success == false {
                    
                }
            }
            TodayViewController.ideaItem.remove(at: indexPath.row)
            if widgetTableView.numberOfRows(inSection: 0) == 1 && indexPath.row == 0 {
                widgetTableView.reloadData()
            }else{
                widgetTableView.beginUpdates()
                widgetTableView.deleteRows(at: [indexPath], with: .top)
                widgetTableView.endUpdates()
            }

        }
    }
}
