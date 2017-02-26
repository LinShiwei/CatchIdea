//
//  TableViewTopBounceDecorateView.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/26.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class TableViewTopBounceDecorateView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Icon-50"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = .flexibleWidth
        addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
