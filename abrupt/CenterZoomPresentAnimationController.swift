//
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class CenterZoomPresentAnimationController: BaseAnimationController {


	override func animateTransition(using context: UIViewControllerContextTransitioning) {
		let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
		let fromView =	fromViewController.view!

		let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)!
		let toView = toViewController.view!

		let fromInitialFrame = context.initialFrame(for: fromViewController)
		let toFinalFrame = context.finalFrame(for: toViewController)

		toView.frame = toFinalFrame
		toView.alpha = 0.5

		let screenBounds = UIScreen.main.bounds
		let fromFinalFrame = CGRect(origin: screenBounds.center, size: CGSize.zero)

		let fromSnapshot = fromView.snapshotView(afterScreenUpdates: false)!
		fromSnapshot.frame = fromInitialFrame

		let container = context.containerView
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

		UIView.animate(withDuration: transitionDuration(using: context),
			delay: 0,
			usingSpringWithDamping: 1,
			initialSpringVelocity: 0.5,
			options: UIViewAnimationOptions(),
			animations: animationsBlock,
			completion: completionBlock)
	}

}
