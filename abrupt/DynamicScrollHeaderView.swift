import UIKit


class DynamicScrollHeaderView: UIView {

	override init(frame: CGRect) {
		debugPrint("init with frame")
		super.init(frame: frame)
	}


	required init?(coder: NSCoder) {
		// When initializing through a nib, init:coder gets called
		debugPrint("init with coder")
		super.init(coder: coder)
	}


	override func awakeFromNib() {
		print("awake from nib")
		super.awakeFromNib()
	}

}
