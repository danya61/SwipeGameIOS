//
//  PresentationManager.swift
//  GestureGameApp
//
//  Created by Danya on 11.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class PresentationManager: UIPresentationController, UIAdaptivePresentationControllerDelegate {
    var chromeView = UIView()
    
    override init(presentedViewController: UIViewController!, presenting presentingViewController: UIViewController!) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        chromeView.backgroundColor = UIColor.red
        chromeView.alpha = 0.4
    }
    
    func  FrameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerView?.bounds
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: (containerBounds?.size)!)
        presentedViewFrame.origin.x = (containerBounds?.size.width)! - presentedViewFrame.size.width
        
        return presentedViewFrame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: CGFloat(floorf(Float(parentSize.width / 3.0))), height: parentSize.height)
    }
    
    override func presentationTransitionWillBegin() {
        chromeView.frame = (self.containerView?.bounds)!
        chromeView.alpha = 0.4
        containerView?.insertSubview(chromeView, at:0)
        let coordinator = presentedViewController.transitionCoordinator
        if (coordinator != nil) {
            coordinator!.animate(alongsideTransition: {
                (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.chromeView.alpha = 1.0
                }, completion:nil)
        } else {
            chromeView.alpha = 1.0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        chromeView.frame = (containerView?.bounds)!
        presentedView?.frame = FrameOfPresentedViewInContainerView()
    }
    
    override func adaptivePresentationStyle(for traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.fullScreen
    }
   
    
}
