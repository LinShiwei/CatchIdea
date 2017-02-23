//
//  InfoAboutTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/23.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class InfoAboutTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
