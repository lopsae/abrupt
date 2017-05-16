import UIKit


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class CubeFlipNavigationAnimationController:
	UIPercentDrivenInteractiveTransition,
	UIViewControllerAnimatedTransitioning,
	UINavigationControllerDelegate
{

	enum Direction {
		case right, left
	}
	var direction = Direction.right

	var shouldCompleteTransition = false
	var transitionInProgress = false
	let panGesture: UIPanGestureRecognizer
	weak var navigationController: UINavigationController?


	override init() {
		panGesture = UIPanGestureRecognizer()
		super.init()

		panGesture.addAction(handlePanGesture)
	}


	func navigationController(
		_ navigationController: UINavigationController,
		animationControllerFor operation: UINavigationControllerOperation,
		from fromVC: UIViewController,
		to toVC: UIViewController
	) -> UIViewControllerAnimatedTransitioning? {
		switch operation {
			case .push:
				direction = .right

			case .pop:
				direction = .left

			case .none:
				break
		}
		return self;
	}


	func navigationController(
		_ navigationController: UINavigationController,
		interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
	) -> UIViewControllerInteractiveTransitioning? {
		if transitionInProgress {
			return self
		}

		return nil
	}


	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		viewController.view.addGestureRecognizer(panGesture)
		self.navigationController = navigationController
	}


	func handlePanGesture() {
		if !transitionInProgress {
			let viewCount = navigationController?.viewControllers.count
			if panGesture.state == .began && viewCount > 1 {
				// Start the pop transition!
				transitionInProgress = true
				navigationController?.popViewController(animated: true)
				return
			}
		}

		let parentView = panGesture.view!.superview!
		let viewTranslation = panGesture.translation(in: parentView)

		switch panGesture.state {
			case .changed:
				let screenWidth = UIScreen.main.bounds.width
				let completedRatio = cgclamp(viewTranslation.x / screenWidth, max:1.0, min: 0.0)
				shouldCompleteTransition = completedRatio > 0.5
				update(completedRatio)

			case .cancelled:
				transitionInProgress = false;
				cancel()

			case .ended:
				transitionInProgress = false;
				if shouldCompleteTransition {
					finish()
				} else {
					cancel()
				}

			case .began, .failed, .possible:
				break
		}
	}


	func transitionDuration(
		using transitionContext: UIViewControllerContextTransitioning?
	) -> TimeInterval {
		return 1.0
	}


	func animateTransition(
		using context: UIViewControllerContextTransitioning
	) {
		let fromViewController = context.viewController(forKey: .from)!
		let fromView =	fromViewController.view!

		let toViewController = context.viewController(forKey: .to)!
		let toView = toViewController.view!

		let mysteryConstant: CGFloat = -0.005
		var angleDirection: CGFloat
		switch(direction) {
			case .right:
				angleDirection = 1.0
				toView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
				fromView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
			case .left:
				angleDirection = -1.0
				toView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
				fromView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
		}

		var fromTransform = CATransform3DMakeRotation(angleDirection * .pi / 2,
			0.0, 1.0, 0.0)
		var toTransform = CATransform3DMakeRotation(-angleDirection * .pi / 2,
			0.0, 1.0, 0.0)
		fromTransform.m34 = mysteryConstant
		toTransform.m34 = mysteryConstant

		let container = context.containerView
		container.transform = CGAffineTransform(
			translationX: angleDirection * container.frame.width / 2.0,
			y: 0)

		toView.layer.transform = toTransform
		container.addSubview(toView)

		let animationsBlock = {
			container.transform = CGAffineTransform(
				translationX: -angleDirection * container.frame.width / 2.0,
				y: 0)
			fromView.layer.transform = fromTransform
			toView.layer.transform = CATransform3DIdentity
		}

		let completionBlock = { (finished: Bool) in
			container.transform = CGAffineTransform.identity
			fromView.layer.transform = CATransform3DIdentity
			toView.layer.transform = CATransform3DIdentity
			fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
			toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)


			let completed = !context.transitionWasCancelled
			if completed {
				fromView.removeFromSuperview()
			} else {
				toView.removeFromSuperview()
			}
			context.completeTransition(completed)
		}

		if context.isInteractive {
			UIView.animate(withDuration: transitionDuration(using: context),
				delay: 0,
				options: .curveLinear,
				animations: animationsBlock,
				completion: completionBlock)
		} else {
			UIView.animate(withDuration: transitionDuration(using: context),
				delay: 0,
				usingSpringWithDamping: 1,
				initialSpringVelocity: 0.5,
				// TODO can be substituted with []?
				options: UIViewAnimationOptions(),
				animations: animationsBlock,
				completion: completionBlock)
		}
	}
}
