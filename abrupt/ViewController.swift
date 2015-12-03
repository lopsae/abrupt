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
	var colorView: UIView!


	init(color: UIColor) {
		super.init(nibName: nil, bundle: nil)
		colorView = UIView()
		colorView.backgroundColor = color
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(colorView)
	}


	override func viewWillAppear(animated: Bool) {
		let margin: CGFloat = 2;
		colorView.frame = view.bounds
		colorView.frame.pushSide(all: margin)
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

