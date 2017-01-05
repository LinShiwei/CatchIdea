//
//  MarkColorsView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/25.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MarkColorsView: UIView {

    internal var currentSelectedColor = Theme.shared.markColors[0] {
        didSet{
            for button in buttons where button.backgroundColor == currentSelectedColor{
                currentSelectedButton = button
            }
        }
    }

    private var currentSelectedButton: UIButton?{
        didSet{
            if let oldButton = oldValue {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: { Void in
                    oldButton.transform = .identity
                }, completion: nil)
            }
            buttonRingLayer.removeFromSuperlayer()
            guard currentSelectedButton != nil else {
                return
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {[unowned self] Void in
                self.currentSelectedButton!.transform = CGAffineTransform(scaleX: self.animateScale, y: self.animateScale)
                }, completion: nil)
            currentSelectedButton?.layer.addSublayer(buttonRingLayer)
        }
    }
    
    private var buttonRingLayer = CALayer()
    private var buttons = [UIButton]()
    
    private let buttonSideLength: CGFloat = 20
    private let animateScale: CGFloat = 1.2
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        buttonRingLayer.frame = CGRect(x: 0, y: 0, width: buttonSideLength, height: buttonSideLength)
        buttonRingLayer.cornerRadius = buttonSideLength/2
        buttonRingLayer.borderColor = UIColor.lightGray.cgColor
        buttonRingLayer.borderWidth = 2
        for view in subviews where view is UIButton {
            if let button = view as? UIButton {
                button.backgroundColor = Theme.shared.markColors[button.tag-10-1]
                button.addTarget(self, action: #selector(didTapColorButton(sender:)), for: .touchUpInside)
                buttons.append(button)

            }
        }

        assert(buttons.count == 6)
        defer {
            if currentSelectedButton == nil {
                currentSelectedButton = buttons[0]
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for button in buttons {
            button.layer.cornerRadius = button.frame.width/2
        }
    }
    
    @objc private func didTapColorButton(sender: UIButton){
        currentSelectedButton = sender
        currentSelectedColor = currentSelectedButton!.backgroundColor!
    }
}

