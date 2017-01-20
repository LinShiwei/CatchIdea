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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WidgetDataManager.shared.getAllExistedIdeaData{[unowned self] (success, items) in
            guard success else { return }
            self.ideaItem = items
            self.widgetTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
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
    
}
