//
//  WeakKeeper.swift
//  abrupt
//
//  Created by Maic Lopez on 12/10/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//


/// WeakKeeper can be used to keep a reference to objects that are kept only
/// as weak references, and thus would be lost after leaving the context in
/// which these where created. The use case is target-action objects or
/// delegates created inline, for which there is no other reference other that
/// the target or delegate property, commonly a weak reference.
/// 
/// WeakKeeper can be instructed to clean all keepsakes for which their weak
/// references have expired, leaving the keepsake free to be disposed.
class WeakKeeper {

	static fileprivate var keepers = [Keeper]()

	static func keep(_ keepsake: AnyObject, weakObject: AnyObject?) {
		let keeper = Keeper(keepsake: keepsake, weakObject: weakObject)
		keepers.append(keeper)
	}


	class Keeper {
		var keepsake: AnyObject
		weak var weakObject: AnyObject?

		init(keepsake: AnyObject, weakObject: AnyObject?) {
			self.keepsake = keepsake
			self.weakObject = weakObject
		}
	}
}


