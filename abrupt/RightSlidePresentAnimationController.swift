//
//  RightSlidePresentAnimationController
//  abrupt
//
//  Created by Maic Lopez Saenz on 12/3/15.
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class RightSlidePresentAnimationController: NSObject,
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
		let fromView = context.viewForKey(UITransitionContextFromViewKey)!
		let container = context.containerView()!

		let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let toView = toViewController.view

		let screenBounds = UIScreen.mainScreen().bounds
		let finalFrame = context.finalFrameForViewController(toViewController)

		var initialFrame = finalFrame
		initialFrame.centerY = screenBounds.centerY
		initialFrame.moveOutside(wSideRect: screenBounds)

		toView.frame = initialFrame
		container.addSubview(toView)

		let animationsBlock = {
			fromView.alpha = 0.5
			toView.frame = finalFrame
		}

		let completionBlock = { (finished: Bool) in
			fromView.alpha = 1
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
