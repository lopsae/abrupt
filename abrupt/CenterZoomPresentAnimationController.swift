//
//  CenterZoomPresentAnimationController
//  abrupt
//
//  Created by Maic Lopez Saenz on 12/3/15.
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class CenterZoomPresentAnimationController: NSObject,
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


	func animationControllerForDismissedController(
		dismissed: UIViewController)
		-> UIViewControllerAnimatedTransitioning?
	{
		return self
	}


	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.5
	}


	func animateTransition(context: UIViewControllerContextTransitioning) {
		let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let fromView =	fromViewController.view

		let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let toView = toViewController.view

		let initialFromFrame = context.initialFrameForViewController(fromViewController)
		let finalToFrame = context.finalFrameForViewController(toViewController)

		toView.frame = finalToFrame
		toView.alpha = 0.5

		let screenBounds = UIScreen.mainScreen().bounds
		let finalFromFrame = CGRectInset(screenBounds, screenBounds.width/2.0, screenBounds.height/2.0)

		let container = context.containerView()!
		container.insertSubview(toView, belowSubview: fromView)

		let animationsBlock = {
			toView.alpha = 1.0
			fromView.frame = finalFromFrame
		}

		let completionBlock = { (finished: Bool) in
			fromView.frame = initialFromFrame
			context.completeTransition(true)
		}

		UIView.animateWithDuration(transitionDuration(context),
			delay: 0,
			usingSpringWithDamping: 1,
			initialSpringVelocity: 0.5,
			options: .TransitionNone,
			animations: animationsBlock,
			completion: completionBlock)
	}
}
