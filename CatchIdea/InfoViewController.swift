//
//  InfoViewController.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/23.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import MessageUI

//enum RegisteredPurchase : String {
//    
//    case purchase1 = "latiao1"
//    case purchase2 = "drink2"
//}
//
class InfoViewController: UIViewController {

    @IBOutlet weak var infoTableView: InfoTableView!
    
    fileprivate let localizationStrings = LocalizationStrings.shared
    fileprivate let appBundleID = Bundle.main.bundleIdentifier ?? "com.catchidea.linshiwei"
    fileprivate let authorEmailAddress = "linshiweicn@126.com"
    fileprivate var registeredPurchase = [String](){
        didSet{
            if registeredPurchase.count > 0 {
                infoTableView.reloadSections(IndexSet(arrayLiteral:1), with: .automatic)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServerManager.shared.getDataFromServer(){ [weak self] (success,suffixs) in
            if success && suffixs != nil {
                self?.registeredPurchase = suffixs!
            }else{
                self?.registeredPurchase = ["latiao1","drink2"]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        infoTableView.isUserInteractionEnabled = true
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
    fileprivate func getProductID(withSuffix suffix:String)->String{
        return appBundleID + "." + suffix
    }
    
    func purchase(_ productID: ProductIdentifier) {
        NetworkActivityIndicatorManager.networkOperationStarted()
        infoTableView.isUserInteractionEnabled = false
        SwiftyStoreKit.purchaseProduct(productID, atomically: true) { [weak self] result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            self?.infoTableView.isUserInteractionEnabled = true
            if case .success(let product) = result {
                // Deliver content from server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            if let alert = self?.alertForPurchaseResult(result) {
                self?.showAlert(alert)
            }
        }
    }
    func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController? {
        switch result {
        case .success(let product):
            print("Purchase Success: \(product.productId)")
            return nil
//            return alertWithTitle("Thank You", message: "Purchase completed")
        case .error(let error):
            print("Purchase Failed: \(error)")
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: "Unknown error. Please contact support")
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
            case .paymentCancelled: // user cancelled the request, etc.
                return nil
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
            }
        }
    }
    func alertWithTitle(_ title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func showAlert(_ alert: UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    fileprivate func openEmail(){
        let subject = "[Catch]Advice"
        
        let url = URL(string: "mailto:?to=\(authorEmailAddress)&subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        let application = UIApplication.shared
        if MFMailComposeViewController.canSendMail() {
            if application.canOpenURL(url!) {
                application.open(url!, options: [:], completionHandler: nil)
            }else{
                showAlert(alertWithTitle("Error", message: "Cannot open url"))
            }
        }else{
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = authorEmailAddress
            let alert = UIAlertController(title: localizationStrings.emailAlertTitle, message: localizationStrings.emailAlertMessage + "\(authorEmailAddress)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: LocalizationStrings.shared.okString, style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        
    
    }
}

extension InfoViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        return nil
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                openEmail()
            case 1:
                iRate.sharedInstance().openRatingsPageInAppStore()

            default:
                break
            }
        case 1:
            guard let cell = tableView.cellForRow(at: indexPath) as? InfoBuyingTableViewCell,let productID = cell.productID else{break}
            purchase(productID)
            break
        default:
            print("only two sections ")
            break
        }
    }
}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return registeredPurchase.count
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
                cell.titleLabel.text = localizationStrings.sendAdvice
                cell.cellImageView.image = #imageLiteral(resourceName: "Idea")
            case 1:
                cell.titleLabel.text = localizationStrings.scoringApp
                cell.cellImageView.image = #imageLiteral(resourceName: "Rating")
            default:
                fatalError("only 2 row in section 0")
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoBuyingTableViewCell", for: indexPath) as! InfoBuyingTableViewCell
            let suffix = registeredPurchase[indexPath.row]
            if suffix.contains("drink"){
                cell.cellImageView.image = #imageLiteral(resourceName: "Wine Bottle")
            }else if suffix.contains("latiao") {
                cell.cellImageView.image = #imageLiteral(resourceName: "French Fries")
            }else if suffix.contains("fruit"){
                cell.cellImageView.image = #imageLiteral(resourceName: "Citrus")
            }else {
                cell.cellImageView.image = #imageLiteral(resourceName: "Sandwich")
            }
            cell.productID = getProductID(withSuffix: suffix)
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
