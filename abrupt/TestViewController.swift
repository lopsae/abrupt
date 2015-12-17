import UIKit

class TestViewController: UIViewController {

	private(set) var foreView: UIView
	private(set) var backgroundView: UIView

	private(set) var topLayoutView: UIView
	private(set) var bottomLayoutView: UIView


	init(foreColor: UIColor) {
		foreView = UIView()
		backgroundView = UIView()
		topLayoutView = UIView()
		bottomLayoutView = UIView()
		super.init(nibName: nil, bundle: nil)

		foreView.backgroundColor = foreColor
		backgroundView.backgroundColor = UIColor.whiteColor()
		topLayoutView.backgroundColor = UIColor.lightGrayColor()
		bottomLayoutView.backgroundColor = UIColor.darkGrayColor()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(backgroundView)
		view.addSubview(bottomLayoutView)
		view.addSubview(topLayoutView)
		view.addSubview(foreView)
	}


	override func viewWillLayoutSubviews() {
		let margin: CGFloat = 2;
		foreView.frame = view.bounds
		foreView.frame.pushSide(all: margin)
		foreView.frame.pushSide(y: topLayoutGuide.length)
		foreView.frame.pushSide(h: bottomLayoutGuide.length)

		backgroundView.frame = view.bounds

		topLayoutView.frame = view.bounds
		topLayoutView.frame.h = topLayoutGuide.length
		topLayoutView.frame.pushSide(all: margin)

		bottomLayoutView.frame = view.bounds
		bottomLayoutView.frame.h = bottomLayoutGuide.length
		bottomLayoutView.frame.hyTranslate = view.bounds.hy
		bottomLayoutView.frame.pushSide(all: margin)
	}

}

