//
//  IdeaListTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit



internal class IdeaListTableViewCell: UITableViewCell {

    @IBOutlet weak var addingDateDescriptionLabel: UILabel!
    @IBOutlet weak var notificationControlButton: UIButton!
    @IBOutlet weak var markColorView: UIView!
    @IBOutlet weak var contentHeaderLabel: UILabel!
    
    internal var ideaData: IdeaData?{
        didSet{
            addingDateDescriptionLabel.text = ideaData?.addingDate.description
            contentHeaderLabel.text = ideaData?.header
        }
    }
    
    internal var delegate: IdeaCellManagerDelegate?
    internal var touchPointInWindow: CGPoint?
    
    private let gap: CGFloat = 4
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let contentLayer = CALayer()
        contentLayer.frame = CGRect(x: gap, y: gap, width: windowBounds.width-gap*2, height: self.frame.height-gap*2)
        contentLayer.cornerRadius = 10
        contentLayer.backgroundColor = Theme.shared.tableViewCellBackgroundColor.cgColor
        layer.insertSublayer(contentLayer, at: 0)
        
        markColorView.layer.backgroundColor = UIColor.red.cgColor
        
        addGesture()
    }
    
    override func layoutSubviews() {
        markColorView.layer.cornerRadius = markColorView.frame.width/2
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPointInWindow = touches.first?.location(in: nil)
        super.touchesEnded(touches, with: event)
    }
    private func addGesture(){
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


