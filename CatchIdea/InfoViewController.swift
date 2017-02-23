//
//  InfoViewController.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/23.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoTableView: InfoTableView!
    
    fileprivate let localizationStrings = LocalizationStrings.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        if let mainVC = transitioningDelegate as? MainViewController {
            mainVC.dimDismissAnimationController.dimCenter = CGPoint(x: 30, y: 42)
        }
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InfoViewController: UITableViewDelegate {
    
}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoAboutTableViewCell", for: indexPath) as! InfoAboutTableViewCell
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = localizationStrings.authorEmailAddress
                cell.cellImageView.image = #imageLiteral(resourceName: "Message")
            case 1:
                cell.titleLabel.text = localizationStrings.sendAdvice
                cell.cellImageView.image = #imageLiteral(resourceName: "Idea")
            case 2:
                cell.titleLabel.text = localizationStrings.scoringApp
                cell.cellImageView.image = #imageLiteral(resourceName: "Rating")
            default:
                fatalError("only 3 row in section 0")
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoBuyingTableViewCell", for: indexPath) as! InfoBuyingTableViewCell
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = localizationStrings.purchaseItem1
                cell.cellImageView.image = #imageLiteral(resourceName: "French Fries")
                cell.priceLabel.text = "$0.99"
            case 1:
                cell.titleLabel.text = localizationStrings.purchaseItem2
                cell.cellImageView.image = #imageLiteral(resourceName: "Wine Bottle")
                cell.priceLabel.text = "$1.99"
            default:
                fatalError("only 2 row in section 1")

            }
            return cell
        default:
            fatalError("There are only two sections")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return localizationStrings.titleForSection0
        case 1:
            return localizationStrings.titleForSection1
        default:
            fatalError("only 2 section ")
        }
    }
}
