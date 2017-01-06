//
//  DimDismissAnimationController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class DimDismissAnimationController: NSObject {
    internal var dimCenter = CGPoint.zero
}

extension DimDismissAnimationController: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CreateIdeaViewController,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
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
        
//        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        
        containerView.addSubview(toVC.view)
//        containerView.addSubview(snapshot!)
        containerView.addSubview(fromVC.view)
        containerView.addSubview(maskView)
        //注意：下面这一行｀snapshot?.mask = maskView｀要放在 containerView.addSubView之后，不然效果会不一样。
//        snapshot?.mask = maskView
        fromVC.view.mask = maskView
        
        let duration = transitionDuration(using: transitionContext)*TimeInterval(distance/windowBounds.height)
//        fromVC.view.isHidden = true
        
        UIView.animateKeyframes(withDuration: duration,delay: 0,options: .calculationModeCubic,animations: {
            maskView.transform = CGAffineTransform(scaleX: 1.0/maskView.frame.width, y: 1.0/maskView.frame.height)
        }, completion: { _ in
//            fromVC.view.isHidden = false
//            snapshot?.removeFromSuperview()
            fromVC.view.mask = nil
            maskView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
