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
    //NSView's zero point is in bottom-left
    
    
    
    internal var selectionDelegate: ColorSelectionDelegate?
    
    private var currentSelectedCell: NSView? {
        didSet{
            if let oldCell = oldValue {
                NSAnimationContext.runAnimationGroup({ context in
                    context.duration = 0.5
                    oldCell.animator().frame = CGRect(x: oldCell.frame.minX+5, y: oldCell.frame.minY+5, width: oldCell.frame.width-10, height: oldCell.frame.height-10)

                }, completionHandler: nil)
                oldCell.layer?.cornerRadius = oldCell.frame.width/2
            }

            cellRingLayer.removeFromSuperlayer()
            guard let cell = self.currentSelectedCell else{
                return
                
            }
            NSAnimationContext.runAnimationGroup({context in
                
                context.duration = 0.5
                cell.animator().frame = CGRect(x: cell.frame.minX-5, y: cell.frame.minY-5, width: cell.frame.width+10, height: cell.frame.height+10)

            }, completionHandler: nil)
            cell.layer?.cornerRadius = cell.frame.width/2

            cell.layer?.addSublayer(cellRingLayer)
        }
    }
    
    private let cellSideLength: CGFloat = 20
    private let animateScale: CGFloat = 1.3
    
    private var cellRingLayer = CALayer()
    private var cells = [NSView]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        backgroundColor = Theme.shared.mainThemeColor
        
        cellRingLayer.frame = CGRect(x: 0, y: 0, width: cellSideLength+10, height: cellSideLength+10)
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
    
    override var isFlipped: Bool{
        return true
    }
    
    private func initCells(withContainerViewFrame containerViewFrame: CGRect){
        guard cells.count == 0 else {return}
        let sideSpace: CGFloat = 20
        let cellSize = CGSize(width: cellSideLength, height: cellSideLength)
        let cellCount: CGFloat = 7
//        let cellGap = (containerViewFrame.width-cellCount*cellSize.width-sideSpace*2)/(cellCount-1)
        let cellGap: CGFloat = 20
        
        for index in 0...Int(cellCount)-1 {
            let cell = NSView(frame: CGRect(origin: CGPoint(x: 5,y: sideSpace+(cellSize.width+cellGap)*CGFloat(index)), size: cellSize))
            cell.wantsLayer = true
            cell.layerContentsRedrawPolicy = .onSetNeedsDisplay
            if index == 0 {
                cell.layer?.backgroundColor = NSColor.white.cgColor
            }else{
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
        guard point.x>=5 && point.x<=25 else {
            return
        }
        for cell in cells {
            if fabs(cell.frame.minY + cell.frame.height/2 - point.y) < cellSideLength/2 {
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
