//
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class BaseAnimationController: NSObject,
	UIViewControllerTransitioningDelegate,
	UIViewControllerAnimatedTransitioning
{

	func animationController(
		forPresented presented: UIViewController,
		presenting: UIViewController,
		source: UIViewController)
		-> UIViewControllerAnimatedTransitioning?
	{
		return self
	}


	func animationController(
		forDismissed dismissed: UIViewController)
		-> UIViewControllerAnimatedTransitioning?
	{
		return self
	}


	/// TO OVERRIDE
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.5
	}


	/// TO OVERRIDE
	func animateTransition(using context: UIViewControllerContextTransitioning) {
		fatalError("Method must be overriden in an extending class")
	}

}

