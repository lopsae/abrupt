//
//  CGExtension.swift
//  abrupt
//
//  Created by Maic Lopez on 12/3/15.
//  Copyright © 2015 Maic Lopez. All rights reserved.
//

import UIKit


extension CGRect {


	/// Shorthand for `rect.origin.x`.
	var x: CGFloat {
		get {
			return origin.x
		}

		mutating set {
			origin.x = newValue
		}
	}


	/// Shorthand for `rect.origin.y`.
	var y: CGFloat {
		get {
			return origin.y
		}

		mutating set {
			origin.y = newValue
		}
	}


	/// Shorthand for `rect.size.width`.
	var w: CGFloat {
		get {
			return size.width
		}

		mutating set {
			size.width = newValue
		}
	}


	/// Shorthand for `rect.size.height`.
	var h: CGFloat {
		get {
			return size.height
		}

		mutating set {
			size.height = newValue
		}
	}


	// The `side` methods modify the side of the rect by their name:
	// * Pushing `x` and `y` increases their value, and decreases `w` and `h`
	// * Pushing `w` and `h` decreases their value
	// * If pushing any side would result on a negative `size` coordinate, then
	// the `size` coordinate is set instead to zero.
	//
	// origin       y side
	//     -> +---------------·
	//        |               |
	//        |               |
	//   x    |       +       | w
	//   side |       center  | side
	//        |               |
	//        ·---------------·
	//              h side
	//


	/// Pushes the `x` side.
	mutating func pushSide(x push: CGFloat) {
		x += push
		if (w > push) {
			w -= push
		} else {
			w = 0
		}
	}


	/// Pushes the `y` side.
	mutating func pushSide(y push: CGFloat) {
		y += push
		if (h > push) {
			h -= push
		} else {
			h = 0
		}
	}


	/// Pushes the `w` side.
	mutating func pushSide(w push: CGFloat) {
		if (w > push) {
			w -= push
		} else {
			w = 0
			x += w - push
		}
	}


	/// Pushes the `h` side.
	mutating func pushSide(h push: CGFloat) {
		if (h > push) {
			h -= push
		} else {
			h = 0
			y += h - push
		}
	}


	/// Pushes all sides.
	/// If the push would result on a rect with negative `size`, then the `size`
	/// coordinate is set to zero and the corresponding `x` or `y` to the
	/// previous center coordinate.
	mutating func pushSide(all push: CGFloat) {
		let previousCenter = CGPoint(x: midX, y: midY)
		if (w > push * 2) {
			x += push;
			w -= push * 2;
		} else {
			x = previousCenter.x
			w = 0
		}
		if (h > push * 2) {
			y += push;
			h -= push * 2;
		} else {
			y = previousCenter.y
			w = 0
		}
	}

}
