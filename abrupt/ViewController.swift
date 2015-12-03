//
//  ViewController.swift
//  abrupt
//
//  Created by Maic Lopez on 12/2/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
		colorView.frame = CGRect(
			x: view.bounds.origin.x + margin,
			y: view.bounds.origin.x + margin,
			width: view.bounds.size.width - margin*2,
			height: view.bounds.size.height - margin*2)
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

