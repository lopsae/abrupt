//
//  CubeFlipNavigationAnimationController
//  abrupt
//
//  Created by Maic Lopez Saenz.
//  Copyright © 2015 Maic Lopez Saenz. All rights reserved.
//

import UIKit


class CubeFlipNavigationAnimationController: UIPercentDrivenInteractiveTransition,
	UIViewControllerAnimatedTransitioning,
	UINavigationControllerDelegate
{

	enum Direction {
		case Right, Left
	}

	var direction = Direction.Right

	let navigationController: UINavigationController

	// Interactive control
	var shouldCompleteTransition = false
	var transitionInProgress = false
	let panGesture: UIPanGestureRecognizer

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.panGesture = UIPanGestureRecognizer()
		super.init()

		panGesture.addAction(handlePanGesture)
	}


	func navigationController(navigationController: UINavigationController,
		animationControllerForOperation operation: UINavigationControllerOperation,
		fromViewController fromVC: UIViewController,
		toViewController toVC: UIViewController)
		-> UIViewControllerAnimatedTransitioning?
	{
		switch operation {
			case .Push:
				direction = .Right

			case .Pop:
				direction = .Left

			case .None:
				break
		}
		return self;
	}


	func navigationController(navigationController: UINavigationController,
		interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning)
		-> UIViewControllerInteractiveTransitioning?
	{

		if transitionInProgress {
			return self
		}

		return nil
	}


	func navigationController(navigationController: UINavigationController,
		didShowViewController viewController: UIViewController,
		animated: Bool)
	{
		viewController.view.addGestureRecognizer(panGesture)
	}


	func handlePanGesture() {
		let parentView = panGesture.view!.superview!
		let viewTranslation = panGesture.translationInView(parentView)

		switch panGesture.state {
			case .Began:
				transitionInProgress = true
				navigationController.popViewControllerAnimated(true)

			case .Changed:
				let mysteryConstant = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 200.0), 0.0), 1.0))
				shouldCompleteTransition = mysteryConstant > 0.5
				updateInteractiveTransition(mysteryConstant)

			case .Cancelled:
				transitionInProgress = false;
				cancelInteractiveTransition()

			case .Ended:
				transitionInProgress = false;
				if shouldCompleteTransition {
					finishInteractiveTransition()
				} else {
					cancelInteractiveTransition()
				}

			default:
				break
		}
	}


	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 1.0
	}


	func animateTransition(context: UIViewControllerContextTransitioning) {
		let fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let fromView =	fromViewController.view

		let toViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let toView = toViewController.view

		let mysteryConstant: CGFloat = -0.005
		var angleDirection: CGFloat
		switch(direction) {
			case .Right:
				angleDirection = 1.0
				toView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
				fromView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
			case .Left:
				angleDirection = -1.0
				toView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
				fromView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
		}

		var fromTransform = CATransform3DMakeRotation(angleDirection * CGFloat(M_PI_2),
			0.0, 1.0, 0.0)
		var toTransform = CATransform3DMakeRotation(-angleDirection * CGFloat(M_PI_2),
			0.0, 1.0, 0.0)
		fromTransform.m34 = mysteryConstant
		toTransform.m34 = mysteryConstant

		let container = context.containerView()!
		container.transform = CGAffineTransformMakeTranslation(
			angleDirection * container.frame.width / 2.0,
			0)

		toView.layer.transform = toTransform
		container.addSubview(toView)

		let animationsBlock = {
			container.transform = CGAffineTransformMakeTranslation(
				-angleDirection * container.frame.width / 2.0,
				0)
			fromView.layer.transform = fromTransform
			toView.layer.transform = CATransform3DIdentity
		}

		let completionBlock = { (finished: Bool) in
			container.transform = CGAffineTransformIdentity
			fromView.layer.transform = CATransform3DIdentity
			toView.layer.transform = CATransform3DIdentity
			fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
			toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)


			let completed = !context.transitionWasCancelled()
			if completed {
				fromView.removeFromSuperview()
			} else {
				toView.removeFromSuperview()
			}
			context.completeTransition(completed)
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