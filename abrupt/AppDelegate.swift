import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var navController: UINavigationController!
	var pushedViewController: TestViewController!
	var presentedViewController: TestViewController!
	var collectionViewController: TestCollectionViewController!
	var scrollHeaderViewController: TestScrollHeaderViewController!


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Initial view
		let initialViewController = TestViewController(colors: [UIColor.gray, UIColor.brown, UIColor.cyan])
		initialViewController.navigationItem.title = "Initial"
		initialViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Push",
			style: .plain)
		{
			[unowned self] in
			self.navController.pushViewController(self.pushedViewController, animated: true)
		}

		let presentGesture = UITapGestureRecognizer() {
			[unowned self] in
			self.navController.present(self.presentedViewController,
				animated: true,
				completion: nil)
		}
		initialViewController.foreViews.first?.addGestureRecognizer(presentGesture)

		let collectionGesture = UITapGestureRecognizer() {
			[unowned self] in
			self.navController.present(self.collectionViewController,
				animated: true,
				completion: nil)
		}
		initialViewController.foreViews[1].addGestureRecognizer(collectionGesture)

		let scrollHeaderGesture = UITapGestureRecognizer() {
			[unowned self] in
			self.navController.present(self.scrollHeaderViewController,
				animated: true,
				completion: nil)
		}
		initialViewController.foreViews[2].addGestureRecognizer(scrollHeaderGesture)

		// Pushed view
		pushedViewController = TestViewController(foreColor: UIColor.red)
		pushedViewController.navigationItem.title = "Pushed"
		pushedViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Pop",
			style: .plain)
		{
			[unowned self] in
			self.navController.popViewController(animated: true)
		}

		// Presented view
		presentedViewController = TestViewController(foreColor: UIColor.magenta)
		let dismissGesture = UITapGestureRecognizer(){
			[unowned self] in
			self.navController.dismiss(animated: true,
				completion: nil)
		}
		presentedViewController.foreViews.first?.addGestureRecognizer(dismissGesture)

		let centerTransitioning = CenterZoomPresentAnimationController()
		presentedViewController.transitioningDelegate = centerTransitioning
		WeakKeeper.keep(centerTransitioning, weakObject: presentedViewController)

		// Collection view
		collectionViewController = TestCollectionViewController()

		// ScrollHeader view
		scrollHeaderViewController = TestScrollHeaderViewController()

		// Navigation
		navController = UINavigationController()
		let navigationDelegate = CubeFlipNavigationAnimationController()
		navController.delegate = navigationDelegate
		WeakKeeper.keep(navigationDelegate, weakObject: navController)

		navController.pushViewController(initialViewController, animated: false)

		// Window
		window = UIWindow(frame: UIScreen.main.bounds)
		window!.backgroundColor = UIColor.lightGray
		window!.rootViewController = navController
		window!.makeKeyAndVisible()

		// Slow motion animations
		// window!.layer.speed = 0.1
		return true
	}


	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

