//
//  MarkColorButton.swift
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/6/27.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Cocoa

class MarkColorView: NSView {

//    internal var markColor = NSColor.red{
//        didSet{
////            layer?.backgroundColor = markColor.cgColor
//        }
//    }
//    
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//
//        // Drawing code here.
//    }
//    
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        wantsLayer = true
//        layer?.cornerRadius = self.frame.width/2
//        layer?.backgroundColor = NSColor.green.cgColor
//        
        
//        stringValue = ""
//        image = nil
//        print(cell)
        
        
//    }
    
    internal var colorIndex: Int16 = -1 {
        didSet{
            switch colorIndex {
            case 0:
                layer?.backgroundColor = NSColor.green.cgColor
            case 1...6:
                layer?.backgroundColor = Theme.shared.markColors[Int(colorIndex-1)].cgColor
            default:
                return
            }
        }

    }
    
    let popover = NSPopover()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.cornerRadius = self.frame.width/2
        layer?.backgroundColor = NSColor.black.cgColor

        if let cell = self.superview as? MarkColorCell {
            bind("colorIndex", to: cell, withKeyPath: "objectValue.markColorIndex", options: nil)
        }
        
//        let gesture = NSClickGestureRecognizer(target: self, action: #selector(showPopover(_:)))
//        addGestureRecognizer(gesture)
    }
    
    override func layout() {
        super.layout()
        layer?.cornerRadius = self.frame.width/2

    }
    
    override func mouseDown(with event: NSEvent) {
//        if let controller = self.window?.contentViewController as? MainViewController_macOS {
//            popover.contentViewController = controller
        let controller = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "popover") as! NSViewController
        popover.contentViewController = controller
//        let controller = NSViewController(nibName: ., bundle: <#T##Bundle?#>)
            popover.show(relativeTo: self.bounds, of: self, preferredEdge: .maxX)
//        }
    }
    
//    internal func showPopover(_ sender: Any){
//        if let controller = self.window?.contentViewController as? MainViewController_macOS {
//            popover.contentViewController = controller
//
//            popover.show(relativeTo: self.bounds, of: self, preferredEdge: .maxX)
//        }
//        
//    }
}
