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
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colorIndicationView.layer.cornerRadius = colorIndicationView.frame.width/2
    }
}
