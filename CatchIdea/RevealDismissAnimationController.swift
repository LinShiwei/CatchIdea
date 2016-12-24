//
//  RevealDismissAnimationController.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/23.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class RevealDismissAnimationController: NSObject {
}

extension RevealDismissAnimationController: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? TrashViewController,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        let containerView = transitionContext.containerView
        
        let center = CGPoint(x: windowBounds.width-1, y: 1)
        let distance = center.maxDistanceToScreenCorner()
        let maskView = UIView()
        maskView.frame.size = CGSize(width: distance*2, height: distance*2)
        maskView.center = center
        maskView.backgroundColor = UIColor.blue
        maskView.layer.cornerRadius = maskView.frame.width/2
        maskView.layer.masksToBounds = true
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        containerView.addSubview(maskView)
        //注意：下面这一行｀snapshot?.mask = maskView｀要放在 containerView.addSubView之后，不然效果会不一样。
        snapshot?.mask = maskView
        
        let duration = transitionDuration(using: transitionContext)
        fromVC.view.isHidden = true

        UIView.animateKeyframes(withDuration: duration,delay: 0,options: .calculationModeCubic,animations: {
            maskView.transform = CGAffineTransform(scaleX: 1.0/maskView.frame.width, y: 1.0/maskView.frame.height)
        }, completion: { _ in
                fromVC.view.isHidden = false
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}

struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransformForContainerView(_ containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}
