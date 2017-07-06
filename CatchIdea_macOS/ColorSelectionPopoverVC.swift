//
//  ColorSelectionPopover.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/6.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

internal class ColorSelectionPopoverVC: NSViewController {

    @IBOutlet weak var containerView: NSView!
    internal var selectedColorIndex = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRingLayer.frame = CGRect(x: 0, y: 0, width: cellSideLength+10, height: cellSideLength+10)
        cellRingLayer.cornerRadius = cellRingLayer.frame.width/2
        cellRingLayer.borderColor = NSColor.lightGray.cgColor
        cellRingLayer.borderWidth = 2
        
        let tapGesture = NSClickGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let panGesture = NSPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    
    
    override func viewDidLayout() {
        super.viewDidLayout()
        initCells(withContainerViewFrame: view.frame)
        
    
    }
    
    private func initCells(withContainerViewFrame containerViewFrame: CGRect){
        guard cells.count == 0 else {return}
        let sideSpace: CGFloat = 20
        let cellSize = CGSize(width: cellSideLength, height: cellSideLength)
        let cellCount: CGFloat = 7
        //        let cellGap = (containerViewFrame.width-cellCount*cellSize.width-sideSpace*2)/(cellCount-1)
        let cellGap: CGFloat = 20
        
        for index in 0...Int(cellCount)-1 {
            let cell = NSView(frame: CGRect(origin: CGPoint(x: sideSpace+(cellSize.width+cellGap)*CGFloat(index),y: 5), size: cellSize))
            cell.wantsLayer = true
            cell.layerContentsRedrawPolicy = .onSetNeedsDisplay
            if index == 0 {
                cell.layer?.backgroundColor = NSColor.white.cgColor
            }else{
                cell.layer?.backgroundColor = Theme.shared.markColors[index-1].cgColor
            }
            cell.layer?.cornerRadius = cell.frame.width/2
            view.addSubview(cell)
            cells.append(cell)
        }
        currentSelectedCell = cells[0]
    }
    
    override func resignFirstResponder() -> Bool {
        return super.resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        return super.becomeFirstResponder()
    }
    
    @objc private func didTap(sender: NSClickGestureRecognizer) {
        selectCell(atPoint: sender.location(in: self.view))
    }
    
    @objc private func didPan(sender: NSPanGestureRecognizer) {
        selectCell(atPoint: sender.location(in: self.view))
    }
    
    private func selectCell(atPoint point: CGPoint) {
        guard point.y>=5 && point.y<=25 else {
            return
        }
        for cell in cells {
            if fabs(cell.frame.minX + cell.frame.width/2 - point.x) < cellSideLength/2 {
                guard currentSelectedCell != cell else { return }
                currentSelectedCell = cell
                if let index = cells.index(of: cell) {
                    selectionDelegate?.didSelectColor(ofColorIndex: index)
                }
                break
            }
        }
    }
    
    
}
