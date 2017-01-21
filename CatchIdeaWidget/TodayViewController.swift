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
    
    fileprivate var ideaItem = [IdeaItem]()
    fileprivate var hasItem: Bool {
        get{
            return ideaItem.count > 0 ? true : false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WidgetDataManager.shared.getAllExistedIdeaData{[unowned self] (success, items) in
            guard success else { return }
            self.ideaItem = items
            self.widgetTableView.reloadData()
        }
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
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
            return ideaItem.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WidgetTableViewCell", for: indexPath) as! WidgetTableViewCell
        if hasItem {
            cell.markColor = ideaItem[indexPath.row].markColor
            cell.header = ideaItem[indexPath.row].header
        }else{
            cell.markColor = UIColor.white
            cell.header = WidgetLocalizationStrings.shared.defaultCellHeader
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
