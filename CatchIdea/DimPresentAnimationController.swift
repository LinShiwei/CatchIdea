//
//  DimPresentAnimationController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class DimPresentAnimationController: NSObject {
    internal var dimCenter = CGPoint.zero
}

extension DimPresentAnimationController: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CreateIdeaViewController else {
                return
        }
        let containerView = transitionContext.containerView
        
        let distance = dimCenter.maxDistanceToScreenCorner()
        let maskView = UIView()
        maskView.frame.size = CGSize(width: distance*2, height: distance*2)
        maskView.center = dimCenter
        maskView.backgroundColor = UIColor.blue
        maskView.layer.cornerRadius = maskView.frame.width/2
        maskView.layer.masksToBounds = true
        maskView.transform = CGAffineTransform(scaleX: 1.0/maskView.frame.width, y: 1.0/maskView.frame.height)
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(maskView)
        //注意：下面这一行｀.mask = maskView｀要放在 containerView.addSubView之后，不然效果会不一样。
        toVC.view.mask = maskView
        
        let duration = transitionDuration(using: transitionContext)*TimeInterval(distance/windowBounds.height)
        
        UIView.animateKeyframes(withDuration: duration,delay: 0,options: .beginFromCurrentState,animations: {
            maskView.transform = .identity
        },completion: { _ in
            toVC.view.mask = nil
            maskView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }
    
}

extension CGPoint {
    func maxDistanceToScreenCorner()->CGFloat{
        guard (self.x>0)&&(self.x<windowBounds.width)&&(self.y>0)&&(self.y<windowBounds.height) else {
            return 0
        }
        let maxDeltaX = self.x > windowBounds.width/2 ? self.x : windowBounds.width-self.x
        let maxDeltaY = self.y > windowBounds.height/2 ? self.y : windowBounds.height-self.y
        return sqrt(maxDeltaX*maxDeltaX + maxDeltaY*maxDeltaY)
    }
}
