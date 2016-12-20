//
//  IdeaListTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit



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

        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftToDeleteIdeaCell(sender:)))
        swipeLeftGesture.direction = .left
        addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightToFinishIdeaCell(sender:)))
        swipeRightGesture.direction = .right
        addGestureRecognizer(swipeRightGesture)
    }

    @objc private func swipeLeftToDeleteIdeaCell(sender: UISwipeGestureRecognizer) {
        delegate?.deleteIdea(sender: self)
    }
    
    @objc private func swipeRightToFinishIdeaCell(sender: UISwipeGestureRecognizer) {
        delegate?.finishIdea?(sender: self)
    }
}


