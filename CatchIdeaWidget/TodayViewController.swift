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
    
    
    
    @IBOutlet weak var markColorView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markColorView.layer.cornerRadius = markColorView.frame.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefault = UserDefaults(suiteName: "group.catchidea")
        if let dic = userDefault?.value(forKey: "firstIdea") as? Dictionary<String, Any> {
            headerLabel.text = dic["header"] as? String ?? ""
            contentTextView.text = dic["content"] as? String ?? ""
            if let colorData = dic["markColor"] as? Data {
                markColorView.backgroundColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? UIColor.blue
            }
            
            
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
