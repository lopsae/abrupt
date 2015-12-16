//
//  ViewController.swift
//  abrupt
//
//  Created by Maic Lopez on 12/2/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private(set)
	var foreView: UIView!

	private(set)
	var backgroundView: UIView!


	init(foreColor: UIColor, backColor: UIColor) {
		super.init(nibName: nil, bundle: nil)
		foreView = UIView()
		foreView.backgroundColor = foreColor
		backgroundView = UIView()
		backgroundView.backgroundColor = backColor
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(backgroundView)
		view.addSubview(foreView)
	}


	override func viewWillAppear(animated: Bool) {
		let margin: CGFloat = 2;
		foreView.frame = view.bounds
		foreView.frame.pushSide(all: margin)
		backgroundView.frame = view.bounds
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

