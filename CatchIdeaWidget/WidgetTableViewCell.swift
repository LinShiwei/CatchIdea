//
//  WidgetTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/19.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

internal protocol WidgetCellManagerDelegate {
    func deleteCell(sender: UITableViewCell)
}

internal class WidgetTableViewCell: UITableViewCell {

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
    
    internal var delegate: WidgetCellManagerDelegate?
    
    @IBOutlet weak var colorIndicationView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colorIndicationView.layer.cornerRadius = colorIndicationView.frame.width/2
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    @IBAction func deleteCell(_ sender: UIButton) {
        delegate?.deleteCell(sender: self)
    }
}
