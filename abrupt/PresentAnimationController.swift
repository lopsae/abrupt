//
//  PresentAnimationController.swift
//  abrupt
//
//  Created by Maic Lopez on 12/3/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import UIKit


class PresentAnimationController: NSObject,
	UIViewControllerAnimatedTransitioning,
	UIViewControllerTransitioningDelegate
{


	func animationControllerForPresentedController(
		presented: UIViewController,
		presentingController presenting: UIViewController,
		sourceController source: UIViewController)
		-> UIViewControllerAnimatedTransitioning?
	{
		return self
	}


	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 2.5
	}


	func animateTransition(context: UIViewControllerContextTransitioning) {
		let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let finalFrame = context.finalFrameForViewController(toViewController)
		let container = context.containerView()!
		let screenBounds = UIScreen.mainScreen().bounds

		toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.h)
		container.addSubview(toViewController.view!)

		let duration = transitionDuration(context)

		let animationsBlock = {
			fromViewController.view.alpha = 0.5
			toViewController.view.frame = finalFrame
		}

		let completionBlock = { (finished: Bool) in
			context.completeTransition(true)
			fromViewController.view.alpha = 1
		}

		UIView.animateWithDuration(duration,
			delay: 0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 0.5,
			options: .CurveLinear,
			animations: animationsBlock,
			completion: completionBlock)
	}
}
