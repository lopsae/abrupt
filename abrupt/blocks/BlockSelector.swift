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
		return #selector(performBlock)
	}

}


extension UIBarButtonItem {
	convenience init(title: String, style: UIBarButtonItemStyle, action: @escaping EmptyBlockType) {
		self.init()
		self.title = title
		self.style = style

		let block = BlockSelector(block: action)
		WeakKeeper.keep(block, weakObject: self)
		self.target = block
		self.action = block.selector()
	}
}


extension UIGestureRecognizer {
	convenience init(action: @escaping EmptyBlockType) {
		self.init()
		addAction(action)
	}


	func addAction(_ action: @escaping EmptyBlockType) {
		let block = BlockSelector(block: action)
		WeakKeeper.keep(block, weakObject: self)
		addTarget(block, action: block.selector())
	}
	
}
