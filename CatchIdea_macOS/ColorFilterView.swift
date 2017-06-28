//
//  ColorFilterView.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/28.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class ColorFilterView: NSView {

    //Should make sure frame.width = 30, frame.height >= 360 in storyboard
    
    
    
    
    internal var selectionDelegate: ColorSelectionDelegate?
    
    private var currentSelectedCell: NSView? {
        didSet{
//            if let oldButton = oldValue {
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: { Void in
//                    oldButton.transform = .identity
//                }, completion: nil)
//            }
//            buttonRingLayer.removeFromSuperlayer()
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {[weak self] Void in
//                if let safeSelf = self {
//                    safeSelf.currentSelectedButton?.transform = CGAffineTransform(scaleX: safeSelf.animateScale, y: safeSelf.animateScale)
//                }
//                }, completion: nil)
//            currentSelectedButton?.layer.addSublayer(buttonRingLayer)
//            
        }
    }
    
    private let cellSideLength: CGFloat = 20
    private let animateScale: CGFloat = 1.3
    
    private var cellRingLayer = CALayer()
    private var cells = [NSView]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        backgroundColor = Theme.shared.mainThemeColor
        
        cellRingLayer.frame = CGRect(x: -2, y: -2, width: cellSideLength+4, height: cellSideLength+4)
        cellRingLayer.cornerRadius = cellRingLayer.frame.width/2
        cellRingLayer.borderColor = NSColor.lightGray.cgColor
        cellRingLayer.borderWidth = 2
        
        let tapGesture = NSClickGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        addGestureRecognizer(tapGesture)
        
        let panGesture = NSPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        addGestureRecognizer(panGesture)
    }
    
    override func layout() {
        super.layout()
        initCells(withContainerViewFrame: frame)
    }
    
    private func initCells(withContainerViewFrame containerViewFrame: CGRect){
        guard cells.count == 0 else {return}
        let sideSpace: CGFloat = 20
        let cellSize = CGSize(width: cellSideLength, height: cellSideLength)
        let cellCount: CGFloat = 7
//        let cellGap = (containerViewFrame.width-cellCount*cellSize.width-sideSpace*2)/(cellCount-1)
        let cellGap: CGFloat = 20
        
        for index in 0...Int(cellCount)-1 {
            let cell = NSView(frame: CGRect(origin: CGPoint(x: sideSpace+(cellSize.width+cellGap)*CGFloat(index),y: 0), size: cellSize))
            if index == 0 {
                cell.wantsLayer = true
                cell.layer?.backgroundColor = NSColor.white.cgColor
            }else{
                cell.wantsLayer = true
                cell.layer?.backgroundColor = Theme.shared.markColors[index-1].cgColor
            }
            cell.layer?.cornerRadius = cell.frame.width/2
            addSubview(cell)
            cells.append(cell)
        }
        currentSelectedCell = cells[0]
    }
    
    
    @objc private func didTap(sender: NSClickGestureRecognizer) {
        selectCell(atPoint: sender.location(in: self))
    }
    
    @objc private func didPan(sender: NSPanGestureRecognizer) {
        selectCell(atPoint: sender.location(in: self))
    }
    
    private func selectCell(atPoint point: CGPoint) {
        for cell in cells {
            if fabs(cell.frame.minX + cell.frame.width/2 - point.x) < cellSideLength/2 {
                guard currentSelectedCell != cell else { return }
                currentSelectedCell = cell
                guard let cgColor = cell.layer?.backgroundColor,let color = NSColor(cgColor: cgColor) else{
                    return
                }
                selectionDelegate?.didSelectColor(color)
                break
            }
        }
    }

}
