//
//  ZoomAnimationController.swift
//  Transition
//
//  Created by Sang Hyeon kim on 2022/12/13.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class ZoomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = TimeInterval(1)

    var targetIndexPath: IndexPath?
    var targetImage: UIImage?
    
    var presenting = true
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if presenting {
            guard let fromVC = transitionContext.viewController(forKey: .from)?.childViewControllers.last as? CustomTransitionViewController else {fatalError()}
            guard let toVC = transitionContext.viewController(forKey: .to) as? ImageViewController else {fatalError()}
            
            
//            guard let fromView = transitionContext.view(forKey: .from) else {fatalError()}
            guard let fromView = fromVC.view else {fatalError()}
            guard let toView = transitionContext.view(forKey: .to) else {fatalError()}
            
            
            toView.alpha = 0.0 //감추기
            containerView.addSubview(toView)
            
            let targetCell = fromVC.listCollectionView.cellForItem(at: targetIndexPath!)
            let startFrame = fromVC.listCollectionView.convert(targetCell!.frame, to: fromView)
            
            let imgView = UIImageView(frame: startFrame)
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.image = targetImage
            containerView.addSubview(imgView)
            
            let finalFrame = containerView.bounds
            UIView.animate(withDuration: duration, delay: 0) {
                imgView.frame = finalFrame
            } completion: { finished in
                toView.alpha = 1.0
                toVC.showCloseButton()
                imgView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            
        } else {
            
            guard let toVC = transitionContext.viewController(forKey: .to)?.childViewControllers.last as? CustomTransitionViewController else { fatalError() }
            guard let fromVC = transitionContext.viewController(forKey: .from) as? ImageViewController else { fatalError() }
            
            toVC.navigationController?.view.frame = containerView.bounds
            containerView.addSubview(toVC.navigationController!.view)
            toVC.view.layoutIfNeeded()
            
            let startFrame = fromVC.imageView.frame
            let imgView = UIImageView(frame: startFrame)
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.image = targetImage
            containerView.addSubview(imgView)
            
            fromVC.view.alpha = 0.0
            
            let targetCell = toVC.listCollectionView.cellForItem(at: targetIndexPath!)
            let finalFrame = toVC.listCollectionView.convert(targetCell!.frame, to: toVC.view)
            
            UIView.animate(withDuration: duration, animations: {
                imgView.frame = finalFrame
            }, completion: { finished in
                let success = !transitionContext.transitionWasCancelled
                imgView.alpha = 0.0
                imgView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
            
        }
    }
    

    
}
