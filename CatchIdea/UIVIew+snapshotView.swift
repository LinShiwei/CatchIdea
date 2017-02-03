//
//  UIVIew+snapshotView.swift
//  CatchIdea
//
//  Created by Linsw on 17/2/3.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import UIKit

internal extension UIView {
    var snapshotView: UIView? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let img = image {
            return UIImageView(image: img)
        }else{
            return nil
        }
    }
}
