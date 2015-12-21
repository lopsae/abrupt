import UIKit


extension UIColor {

	func lighten(increment: CGFloat) -> UIColor {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)

		red += increment
		green += increment
		blue += increment

		red.clamp(max: 1, min: 0)
		green.clamp(max: 1, min: 0)
		blue.clamp(max: 1, min: 0)

		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}


	func darken(decrement: CGFloat) -> UIColor {
		return lighten(-decrement)
	}

}
