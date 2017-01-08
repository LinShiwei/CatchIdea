//
//  SharedNavigationBar.swift
//  CatchIdea
//
//  Created by Linsw on 17/1/2.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

class SharedNavigationBar: UINavigationBar {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
}
