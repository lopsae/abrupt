//
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class CenterZoomPresentAnimationController: BaseAnimationController {


	override func animateTransition(context: UIViewControllerContextTransitioning) {
		let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let fromView =	fromViewController.view

		let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let toView = toViewController.view

		let fromInitialFrame = context.initialFrameForViewController(fromViewController)
		let toFinalFrame = context.finalFrameForViewController(toViewController)

		toView.frame = toFinalFrame
		toView.alpha = 0.5

		let screenBounds = UIScreen.mainScreen().bounds
		let fromFinalFrame = CGRect(origin: screenBounds.center, size: CGSizeZero)

		let fromSnapshot = fromView.snapshotViewAfterScreenUpdates(false)
		fromSnapshot.frame = fromInitialFrame

		let container = context.containerView()!
		container.addSubview(fromSnapshot)
		fromViewController.removeFromParentViewController()
		container.insertSubview(toView, belowSubview: fromSnapshot)

		let animationsBlock = {
			toView.alpha = 1.0
			fromSnapshot.frame = fromFinalFrame
		}

		let completionBlock = { (finished: Bool) in
			fromSnapshot.removeFromSuperview()
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
