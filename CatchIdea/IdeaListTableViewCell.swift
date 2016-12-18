//
//  IdeaListTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal protocol IdeaCellManagerDelegate {
    func deleteIdea(sender: IdeaListTableViewCell)
    func finishIdea(sender: IdeaListTableViewCell)
}

internal class IdeaListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentHeaderLabel: UILabel!
    
    internal var header = "" {
        didSet{
            contentHeaderLabel.text = header
        }
    }
    
    internal var delegate : IdeaCellManagerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(IdeaListTableViewCell.swipeLeftToDeleteIdeaCell(sender:)))
        swipeLeftGesture.direction = .left
        addGestureRecognizer(swipeLeftGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc private func swipeLeftToDeleteIdeaCell(sender: UISwipeGestureRecognizer) {
        delegate?.deleteIdea(sender: self)
    }
}


