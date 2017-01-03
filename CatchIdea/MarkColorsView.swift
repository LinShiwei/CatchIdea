//
//  MarkColorsView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/25.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class MarkColorsView: UIView {

    internal var currentSelectedColor = Theme.shared.markColors[0]{
        didSet{
            for button in buttons where button.backgroundColor == currentSelectedColor{
                buttonRingLayer.removeFromSuperlayer()
                button.layer.addSublayer(buttonRingLayer)
            }
        }
    }
    
    private var buttonRingLayer = CALayer()
    private var buttons = [UIButton]()
    
    private let buttonSideLength: CGFloat = 30
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        buttonRingLayer.frame = CGRect(x: 0, y: 0, width: buttonSideLength, height: buttonSideLength)
        buttonRingLayer.cornerRadius = buttonSideLength/2
        buttonRingLayer.borderColor = UIColor.lightGray.cgColor
        buttonRingLayer.borderWidth = 2
        for view in subviews where view is UIButton {
            if let button = view as? UIButton {
                button.backgroundColor = Theme.shared.markColors[button.tag-1]
                button.addTarget(self, action: #selector(didTapColorButton(sender:)), for: .touchUpInside)
                buttons.append(button)

            }
        }

        assert(buttons.count == 6)
        buttons[0].layer.addSublayer(buttonRingLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for button in buttons {
            button.layer.cornerRadius = button.frame.width/2
        }
    }
    
    @objc private func didTapColorButton(sender: UIButton){
        currentSelectedColor = sender.backgroundColor!
    }
}

