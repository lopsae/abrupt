import UIKit

class TestViewController: UIViewController {

	fileprivate(set) var foreViews: [UIView]

	fileprivate(set) var backgroundView: UIView
	fileprivate(set) var topLayoutView: UIView
	fileprivate(set) var bottomLayoutView: UIView


	init(colors: [UIColor]) {
		foreViews = []
		backgroundView = UIView()
		topLayoutView = UIView()
		bottomLayoutView = UIView()
		super.init(nibName: nil, bundle: nil)

		for currentColor in colors {
			let currentView = UIView()
			currentView.backgroundColor = currentColor
			foreViews.append(currentView)
		}

		backgroundView.backgroundColor = UIColor.white
		topLayoutView.backgroundColor = UIColor.lightGray
		bottomLayoutView.backgroundColor = UIColor.darkGray
	}


	convenience init(foreColor: UIColor) {
		self.init(colors: [foreColor])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(backgroundView)
		view.addSubview(bottomLayoutView)
		view.addSubview(topLayoutView)

		for currentView in foreViews {
			view.addSubview(currentView)
		}
	}


	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		let margin: CGFloat = 2;

		var totalForeFrame = view.bounds
		totalForeFrame.pushSide(y: topLayoutGuide.length)
		totalForeFrame.pushSide(h: bottomLayoutGuide.length)
		var baseForeFrame = totalForeFrame
		baseForeFrame.h = totalForeFrame.height / CGFloat(foreViews.count)

		for (index, currentView) in foreViews.enumerated() {
			currentView.frame = baseForeFrame
			currentView.frame.y += baseForeFrame.height * CGFloat(index)
			currentView.frame.pushSide(all: margin)
		}

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

