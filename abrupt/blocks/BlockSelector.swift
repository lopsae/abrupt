//
//  BlockSelector.swift
//  abrupt
//
//  Created by Maic Lopez on 12/4/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import Foundation
import UIKit

typealias EmptyBlockType = () -> Void

class BlockSelector {

	var block: EmptyBlockType?

	init(block: EmptyBlockType?) {
		self.block = block
	}


	convenience init() {
		self.init(block: nil)
	}


	@objc
	func performBlock() {
		guard let block = block else {
			return
		}
		block()
	}


	func selector() -> Selector {
		return "performBlock"
	}


	// These keepers are used to keep a reference to blocks created in the
	// extensions bellow. Since usualy target/action properties are weak, the
	// BlockSelector if created inline is lost. This array just keeps the
	// reference alive. If there is a way to track when the garbage collector
	// runs then its possible to scan through the keeper objects and detect
	// that the weakObject has been deleted and thus break the keepsake
	// reference.
	static private var keepers = [Keeper]()

	static func keep(keepsake: AnyObject, weakObject: AnyObject) {
		let keeper = Keeper(keepsake: keepsake, weakObject: weakObject)
		keepers.append(keeper)
	}


	class Keeper {
		var keepsake: AnyObject
		weak var weakObject: AnyObject?

		init(keepsake: AnyObject, weakObject: AnyObject) {
			self.keepsake = keepsake
			self.weakObject = weakObject
		}
	}

}


extension UIBarButtonItem {
	convenience init(title: String, style: UIBarButtonItemStyle, action: EmptyBlockType) {
		self.init()
		self.title = title
		self.style = style

		let block = BlockSelector(block: action)
		BlockSelector.keep(block, weakObject: self)
		self.target = block
		self.action = block.selector()
	}
}


extension UIGestureRecognizer {
	convenience init(action: EmptyBlockType) {
		self.init()

		let block = BlockSelector(block: action)
		BlockSelector.keep(block, weakObject: self)
		addTarget(block, action: block.selector())
	}
}
