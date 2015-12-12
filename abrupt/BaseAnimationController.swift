//
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class BaseAnimationController: NSObject,
	UIViewControllerTransitioningDelegate,
	UIViewControllerAnimatedTransitioning
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


	/// TO OVERRIDE
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.5
	}


	/// TO OVERRIDE
	func animateTransition(context: UIViewControllerContextTransitioning) {
		fatalError("Method must be overriden in an extending class")
	}

}

