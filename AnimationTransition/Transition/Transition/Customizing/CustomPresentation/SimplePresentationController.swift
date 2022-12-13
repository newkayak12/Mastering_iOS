//
//  SimplePresentationController.swift
//  Transition
//
//  Created by Sang Hyeon kim on 2022/12/13.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class SimplePresentationController: UIPresentationController {

    let dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    let closeButton = UIButton(type: .custom)
    var closeButtonTopConstraint: NSLayoutConstraint?
    
    let workaroundView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
        
        closeButton.setImage(UIImage(systemName: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func dismiss(){
        presentedViewController.dismiss(animated: true)
    }
    override var frameOfPresentedViewInContainerView: CGRect{
        print(#function, String(describing: type(of: self)))
        
        guard var frame = containerView?.frame else { return .zero }
        frame.origin.y = frame.size.height / 2
        frame.size.height = frame.size.height / 2
        
        return frame
    }
    
    override func presentationTransitionWillBegin() {
        print(#function, String(describing: type(of: self)))
        guard let containerView = containerView else { fatalError() }
        dimmingView.alpha = 0.0
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
        
        workaroundView.frame = dimmingView.bounds
        workaroundView.isUserInteractionEnabled = false
        containerView.insertSubview(workaroundView, aboveSubview: dimmingView)
        
        containerView.addSubview(closeButton)
        closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  -80)
        closeButtonTopConstraint?.isActive = true
        containerView.layoutIfNeeded()
        
        closeButtonTopConstraint?.constant = 60
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            presentedViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
            return
        }
        
        coordinator.animate(alongsideTransition: {(context) in
            self.dimmingView.alpha = 1.0
            self.presentedViewController.view.transform  = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
        }, completion:  nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        print(#function, String(describing: type(of: self)))
    }
    
    override func dismissalTransitionWillBegin() {
        print(#function, String(describing: type(of: self)))
        closeButtonTopConstraint?.constant = -80
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            containerView?.layoutIfNeeded()
            return
        }
        
        coordinator.animate(alongsideTransition: {(context) in
            self.dimmingView.alpha = 0.0
            self.presentedViewController.view.transform = CGAffineTransform.identity
            self.containerView?.layoutIfNeeded()
        })
        
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print(#function, String(describing: type(of: self)))
    }
    
    
    override func containerViewWillLayoutSubviews() {
        print(#function, String(describing: type(of: self)))
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerView!.bounds
    }
    override func containerViewDidLayoutSubviews() {
        print(#function, String(describing: type(of: self)))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        presentedViewController.view.transform = CGAffineTransform.identity
        coordinator.animate(alongsideTransition: {(context) in
            self.presentedViewController.view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            
        })
    }
    
}
