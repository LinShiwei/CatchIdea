//
//  WidgetTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/19.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class WidgetTableViewCell: UITableViewCell {

    internal var header = "" {
        didSet{
            headerLabel.text = header
        }
    }
    internal var markColor = UIColor.white {
        didSet {
            colorIndicationView.backgroundColor = markColor
        }
    }
    
    @IBOutlet weak var colorIndicationView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let image = #imageLiteral(resourceName: "Delete").withRenderingMode(.alwaysTemplate)
//        deleteButton.setImage(image, for: .normal)
//        deleteButton.tintColor = UIColor.black
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colorIndicationView.layer.cornerRadius = colorIndicationView.frame.width/2
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    @IBAction func deleteCell(_ sender: UIButton) {
    }
}
