//
//  AppStoreManager.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit
class AppStoreManager: NSObject {
    static let shared = AppStoreManager()
    
    private override init() {
    }
    
    internal func purchaseProductWith(productID: String, completion: @escaping (()->Void)) {
        SwiftyStoreKit.purchaseProduct(productID, atomically: true) {result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            if case .success(let product) = result {
                // Deliver content from server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            completion()
        }
    }
    
    internal func retrieveProductsInfoWith(productID:String, completion: @escaping ((SKProduct)->Void)){
        SwiftyStoreKit.retrieveProductsInfo([productID]) {[weak self ] result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            if let product = result.retrievedProducts.first {
//                let priceString = product.localizedPrice!
//                print("Product: \(product.localizedDescription), price: \(priceString)")
//                self?.titleLabel.text = product.localizedTitle
//                self?.priceLabel.text = priceString
                completion(product)
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Could not retrieve product info .Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(result.error)")
            }
        }
    }
    
    internal func completeTransactions(){
        SwiftyStoreKit.completeTransactions(atomically: true) { products in
            
            for product in products {
                
                if product.transaction.transactionState == .purchased || product.transaction.transactionState == .restored {
                    
                    if product.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(product.transaction)
                    }
                    print("purchased: \(product.productId)")
                }
            }
        }
    }
}
