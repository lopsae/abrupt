import UIKit

class TestScrollHeaderViewController: UIViewController,
	UIScrollViewDelegate
{

	var scrollView: UIScrollView!
	var contentView: UIView!
	var headerView: UIView!

	var firstLayout = true

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.cyanColor()

		contentView = UIView()
		contentView.backgroundColor = UIColor.blueColor()

		scrollView = UIScrollView()
		view.addSubview(scrollView)
		scrollView.delegate = self
		scrollView.addSubview(contentView)

		headerView = UIView()
		headerView.backgroundColor = UIColor.orangeColor().colorWithAlphaComponent(0.5)
		view.addSubview(headerView)
	}


	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		if firstLayout {
			firstLayout = false
			scrollView.frame = view.bounds
			contentView.frame = scrollView.bounds
			contentView.frame.h = scrollView.bounds.height * 2

			// `y` is reset so that updates in contentOffset ocurr correctly
			contentView.frame.y = 0

			scrollView.contentSize = contentView.frame.size
			scrollView.contentInset.top = view.bounds.width
			scrollView.contentOffset.y = -view.bounds.width

			headerView.frame.w = view.bounds.width
			headerView.frame.h = view.bounds.width
		}
	}


	func scrollViewDidScroll(scrollView: UIScrollView) {
		let minHeaderHeight:CGFloat = 80
		headerView.frame.h = cgclamp(-scrollView.contentOffset.y,
			max: view.bounds.width,
			min: minHeaderHeight)
//		debugPrint(scrollView.contentOffset)
	}


}