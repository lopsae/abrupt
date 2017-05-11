import UIKit


public func cgclamp(_ value: CGFloat, max maxValue: CGFloat, min minValue: CGFloat) -> CGFloat {
	return CGFloat(fminf(fmaxf(Float(value), Float(minValue)), Float(maxValue)))
}


extension CGFloat {

	mutating func clamp(max maxValue: CGFloat, min minValue: CGFloat) {
		self = cgclamp(self, max: maxValue, min: minValue)
	}

}


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


	/// Shorthand for the `x` position of the `w` side. Setting this property
	/// value only modifies `w`.
	var wx: CGFloat {
		get {
			return x + w
		}

		mutating set {
			w = newValue - x
		}
	}


	/// Shorthand for the `y` position of the `h` side. Setting this property
	/// value only modifies `h`.
	var hy: CGFloat {
		get {
			return y + h
		}

		mutating set {
			h = newValue - y
		}
	}


	/// Returns the same value as `wx`. Setting this property value only
	/// modifies `x`.
	var wxTranslate: CGFloat {
		get {
			return wx
		}

		mutating set {
			x = newValue - w
		}
	}


	/// Returns the same value as `hy`. Setting this property value only
	/// modifies `y`.
	var hyTranslate: CGFloat {
		get {
			return hy
		}

		mutating set {
			y = newValue - h
		}
	}


	var centerX: CGFloat {
		get {
			return midX
		}

		mutating set {
			origin.x = newValue - (w / 2.0)
		}
	}


	var centerY: CGFloat {
		get {
			return midY
		}

		mutating set {
			origin.y = newValue - (h / 2.0)
		}
	}


	var center: CGPoint {
		get {
			return CGPoint(x: midX, y: midY)
		}

		mutating set {
			centerX = newValue.x
			centerY = newValue.y
		}
	}


	//TODO: push methods could be renamed to Inset

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
		if (w > push * 2.0) {
			x += push;
			w -= push * 2.0;
		} else {
			x = previousCenter.x
			w = 0
		}
		if (h > push * 2.0) {
			y += push;
			h -= push * 2.0;
		} else {
			y = previousCenter.y
			w = 0
		}
	}


	/// Moves the instance outside of the given rect so that the instance `y`
	/// side is touching `h` side of the `hSideRect` rect. This method will only
	/// modify the `y` property of the instance.
	mutating func moveOutside(hSideRect sideRect:CGRect) {
		y = sideRect.y + sideRect.height
	}


	/// Moves the instance outside of the given rect so that the instance `x`
	/// side is touching `w` side of the `wSideRect` rect. This method will only
	/// modify the `y` property of the instance.
	mutating func moveOutside(wSideRect sideRect:CGRect) {
		x = sideRect.x + sideRect.width
	}

}
