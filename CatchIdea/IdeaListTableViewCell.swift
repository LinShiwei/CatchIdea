//
//  IdeaListTableViewCell.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/17.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit



internal class IdeaListTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationControlButton: UIButton!
    @IBOutlet weak var markColorIndicationView: UIView!
    @IBOutlet weak var contentHeaderLabel: UILabel!
    
    internal var ideaData: IdeaData?{
        didSet{
            notificationControlButton.isHidden = (ideaData?.notificationDate != nil) ? false : true
            markColorIndicationView.layer.backgroundColor = ideaData?.markColor.cgColor
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
        
        markColorIndicationView.layer.backgroundColor = UIColor.red.cgColor
        addGesture()
        
        LocalNotificationManager.shared.addObserver(self, forKeyPath: "currentNotificationIdentifier", options: .new, context: nil)
    }
    
    override func layoutSubviews() {
        markColorIndicationView.layer.cornerRadius = markColorIndicationView.frame.width/2
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPointInWindow = touches.first?.location(in: nil)
        super.touchesEnded(touches, with: event)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let notificationIdentifier = change?[.newKey] as? String,let ideaIdentifier = ideaData?.identifier {
            if notificationIdentifier == ideaIdentifier {
                cancleNotification(notificationControlButton)
            }
            
        }
    }
    
    private func addGesture(){
        let cellSliderGestureRecognizer = DRCellSlideGestureRecognizer()
        let squareAction = DRCellSlideAction(forFraction: 0.25)
        squareAction?.icon = #imageLiteral(resourceName: "square")
        squareAction?.activeBackgroundColor = UIColor.red
        squareAction?.behavior = .pushBehavior
        squareAction?.didTriggerBlock = { Void in
            self.delegate?.finishIdea?(sender: self)
        }
        let circleAction = DRCellSlideAction(forFraction: -0.25)
        circleAction?.icon = #imageLiteral(resourceName: "circle")
        circleAction?.activeBackgroundColor = UIColor.red
        circleAction?.behavior = .pushBehavior
        circleAction?.didTriggerBlock = { Void in
            self.delegate?.deleteIdea(sender: self)
        }
        
        cellSliderGestureRecognizer.addActions([squareAction, circleAction])
        addGestureRecognizer(cellSliderGestureRecognizer)
    }
 
    @IBAction func cancleNotification(_ sender: UIButton) {
        if let data = ideaData, data.notificationDate != nil {
            DataManager.shared.deleteIdeaDataNotification(ideaData: data)
            data.notificationDate = nil
            sender.isHidden = true
        }
    }
    
    deinit {
        LocalNotificationManager.shared.removeObserver(self, forKeyPath: "currentNotificationIdentifier")
    }
}


