//
//  RevealPresentAnimationController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class RevealPresentAnimationController: NSObject {

}

extension RevealPresentAnimationController: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
