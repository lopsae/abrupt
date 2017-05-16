import UIKit


class RightSlidePresentAnimationController: NSObject,
	UIViewControllerAnimatedTransitioning,
	UIViewControllerTransitioningDelegate
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


	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.5
	}


	func animateTransition(using context: UIViewControllerContextTransitioning) {
		let fromView = context.view(forKey: .from)!
		let container = context.containerView

		let toViewController = context.viewController(forKey: .to)!
		let toView = toViewController.view!

		let screenBounds = UIScreen.main.bounds
		let finalFrame = context.finalFrame(for: toViewController)

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

		UIView.animate(withDuration: transitionDuration(using: context),
			delay: 0,
			usingSpringWithDamping: 1,
			initialSpringVelocity: 0.5,
			options: UIViewAnimationOptions(),
			animations: animationsBlock,
			completion: completionBlock)
	}
}
