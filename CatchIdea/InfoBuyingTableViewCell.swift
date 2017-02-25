//
//  InfoBuyingTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/23.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit
import SwiftyStoreKit

class InfoBuyingTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    internal var productID: String?{
        didSet{
            guard let productID = productID else {
                return
            }
            NetworkActivityIndicatorManager.networkOperationStarted()
            SwiftyStoreKit.retrieveProductsInfo([productID]) {[unowned self ] result in
                NetworkActivityIndicatorManager.networkOperationFinished()
                if let product = result.retrievedProducts.first {
                    let priceString = product.localizedPrice!
                    print("Product: \(product.localizedDescription), price: \(priceString)")
                    self.titleLabel.text = product.localizedTitle
                    self.priceLabel.text = priceString
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
