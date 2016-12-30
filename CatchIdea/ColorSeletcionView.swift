//
//  ColorSeletcionView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/30.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

protocol ColorSelectionDelegate {
    func didSelectColor(_ color: UIColor)
}

class ColorSeletcionView: UIView {

    internal var selectionDelegate: ColorSelectionDelegate?
    
    private var currentSelectedColor = UIColor.white{
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        initButtons(withContainerViewFrame: frame)
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
                button.layer.addSublayer(buttonRingLayer)
            }else{
                button.backgroundColor = Theme.shared.markColors[index-1]
            }
            button.addTarget(self, action: #selector(didTapColorButton(sender:)), for: .touchUpInside)
            button.layer.cornerRadius = button.frame.width/2
            addSubview(button)
            buttons.append(button)
        }
    }
    @objc private func didTapColorButton(sender: UIButton){
        currentSelectedColor = sender.backgroundColor!
        selectionDelegate?.didSelectColor(currentSelectedColor)
    }

}
