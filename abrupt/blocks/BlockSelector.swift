//
//  BlockSelector.swift
//  abrupt
//
//  Created by Maic Lopez on 12/4/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import Foundation

typealias EmptyBlockType = () -> ()

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


}
