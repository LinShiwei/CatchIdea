//
//  AppStoreManager.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import SwiftyStoreKit
//import StoreKit
class AppStoreManager: NSObject {
    static let shared = AppStoreManager()
    
    private override init() {
    }
    
    internal func retrieveProductsInfoWith(productID:String, completion:((SKProduct)->Void)){
        SwiftyStoreKit.retrieveProductsInfo([productID]) {[weak self ] result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                self?.titleLabel.text = product.localizedTitle
                self?.priceLabel.text = priceString
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Could not retrieve product info .Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(result.error)")
            }
        }
    }
}
