//
//  TrashTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/18.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class TrashTableViewCell: UITableViewCell {

    @IBOutlet weak var markColorIndicationView: UIView!
    @IBOutlet weak var contentHeaderLabel: UILabel!
    
    internal var ideaData: IdeaData?{
        didSet{
            contentHeaderLabel.text = ideaData?.header
            markColorIndicationView.layer.backgroundColor = ideaData?.markColor.cgColor
        }
    }
    
    internal var delegate : IdeaCellManagerDelegate?
    
    private let gap: CGFloat = 4
    
    override func awakeFromNib() {
        super.awakeFromNib()

        markColorIndicationView.layer.backgroundColor = UIColor.red.cgColor
        
        addGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        markColorIndicationView.layer.cornerRadius = markColorIndicationView.frame.width/2
    }
    
    private func addGesture(){
        let cellSliderGestureRecognizer = DRCellSlideGestureRecognizer()
        let squareAction = DRCellSlideAction(forFraction: 0.25)
        squareAction?.icon = #imageLiteral(resourceName: "square")
        squareAction?.activeBackgroundColor = Theme.shared.trashVCCellSwipeRightColor
        squareAction?.behavior = .pushBehavior
        squareAction?.didTriggerBlock = { Void in
            self.delegate?.restoreIdea?(sender: self)
        }
        let circleAction = DRCellSlideAction(forFraction: -0.25)
        circleAction?.icon = #imageLiteral(resourceName: "circle")
        circleAction?.activeBackgroundColor = Theme.shared.trashVCCellSwipeLeftColor
        circleAction?.behavior = .pushBehavior
        circleAction?.didTriggerBlock = { Void in
            self.delegate?.deleteIdea(sender: self)
        }
        
        cellSliderGestureRecognizer.addActions([squareAction, circleAction])
        addGestureRecognizer(cellSliderGestureRecognizer)
        
    }
    
}
