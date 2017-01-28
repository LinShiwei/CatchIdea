//
//  CellColorSelectionView.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/28.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class CellColorSelectionView: UIView {

    internal var selectionDelegate: ColorSelectionDelegate?
    
    private var currentSelectedButton: UIButton? {
        didSet{
//            if let oldButton = oldValue {
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: { Void in
//                    oldButton.transform = .identity
//                }, completion: nil)
//            }
//            buttonRingLayer.removeFromSuperlayer()
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {[unowned self] Void in
//                self.currentSelectedButton?.transform = CGAffineTransform(scaleX: self.animateScale, y: self.animateScale)
//                }, completion: nil)
//            currentSelectedButton?.layer.addSublayer(buttonRingLayer)
//            
        }
    }
    
    internal var currentMarkColor: UIColor? = nil {
        didSet{
            currentMarkColorView.layer.backgroundColor = currentMarkColor?.cgColor
        }
    }
    
    private let currentMarkColorView = UIView()
    
    private let buttonSideLength: CGFloat = 20
    private let animateScale: CGFloat = 1.3
    
    private var buttonRingLayer = CALayer()
    private var buttons = [UIButton]()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(currentMarkColorView)
//        
//        buttonRingLayer.frame = CGRect(x: -2, y: -2, width: buttonSideLength+4, height: buttonSideLength+4)
//        buttonRingLayer.cornerRadius = buttonRingLayer.frame.width/2
//        buttonRingLayer.borderColor = UIColor.lightGray.cgColor
//        buttonRingLayer.borderWidth = 2
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
//        addGestureRecognizer(tapGesture)
//        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
//        addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currentMarkColorView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        currentMarkColorView.layer.cornerRadius = currentMarkColorView.frame.width/2
        
//        initButtons(withContainerViewFrame: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
        print(superview?.superview)
        if let cell = superview?.superview as? IdeaListTableViewCell {
            cell.isUserInteractionEnabled = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
        if let cell = superview?.superview as? IdeaListTableViewCell {
            cell.isUserInteractionEnabled = true
        }
    }
    
    private func initButtons(withContainerViewFrame containerViewFrame: CGRect){
        guard buttons.count == 0 else {return}
        let sideSpace: CGFloat = 20
        let buttonSize = CGSize(width: buttonSideLength, height: buttonSideLength)
        let buttonCount: CGFloat = 7
        let buttonGap = (containerViewFrame.width-buttonCount*buttonSize.width-sideSpace*2)/(buttonCount-1)
        
        for index in 0...Int(buttonCount)-1 {
            let button = UIButton(frame: CGRect(origin: CGPoint(x: 20+(buttonSize.width+buttonGap)*CGFloat(index),y: 0), size: buttonSize))
            if index == 0 {
                button.backgroundColor = UIColor.white
            }else{
                button.backgroundColor = Theme.shared.markColors[index-1]
            }
            button.layer.cornerRadius = button.frame.width/2
            button.isUserInteractionEnabled = false
            addSubview(button)
            buttons.append(button)
        }
        currentSelectedButton = buttons[0]
    }
    
    
    @objc private func didTap(sender: UITapGestureRecognizer) {
        selectButton(atPoint: sender.location(in: self))
    }
    
    @objc private func didPan(sender: UIPanGestureRecognizer) {
        selectButton(atPoint: sender.location(in: self))
    }
    
    private func selectButton(atPoint point: CGPoint) {
        for btn in buttons {
            if fabs(btn.center.x - point.x) < buttonSideLength/2 {
                guard currentSelectedButton != btn else { return }
                currentSelectedButton = btn
                selectionDelegate?.didSelectColor(btn.backgroundColor!)
                break
            }
        }
    }
}
