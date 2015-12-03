//
//  AppDelegate.swift
//  abrupt
//
//  Created by Maic Lopez on 12/2/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var navController: UINavigationController!
	var pushedViewController: ViewController!
	var presentedViewController: ViewController!


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Initial view
		let initialViewController = ViewController(color: UIColor.grayColor())
		initialViewController.navigationItem.title = "Initial"
		initialViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Push",
			style: .Plain,
			target: self,
			action: "pushAction")

		let presentGesture = UITapGestureRecognizer(
			target: self,
			action: "presentAction")
		initialViewController.colorView.addGestureRecognizer(presentGesture)

		// Pusheded view
		pushedViewController = ViewController(color: UIColor.redColor())
		pushedViewController.navigationItem.title = "Pushed"
		pushedViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Pop",
			style: .Plain,
			target: self,
			action: "popAction")

		// Presented view
		presentedViewController = ViewController(color: UIColor.magentaColor())
		let dismissGesture = UITapGestureRecognizer(
			target: self,
			action: "dismissAction")
		presentedViewController.colorView.addGestureRecognizer(dismissGesture)

		// Navigation
		navController = UINavigationController()
		navController.pushViewController(initialViewController, animated: false)

		// Window
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window!.backgroundColor = UIColor.whiteColor()
		window!.rootViewController = navController
		window!.makeKeyAndVisible()
		return true
	}


	func pushAction() {
		navController.pushViewController(pushedViewController, animated: true)
	}


	func popAction() {
		navController.popViewControllerAnimated(true)
	}


	func presentAction() {
		navController.presentViewController(presentedViewController,
			animated: true,
			completion: nil)
	}


	func dismissAction() {
		navController.dismissViewControllerAnimated(true,
			completion: nil)
	}


	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

