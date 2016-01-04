import UIKit

class TestScrollHeaderViewController: UIViewController,
	UIScrollViewDelegate
{

	var scrollView: UIScrollView!
	var contentView: UIView!
	var headerView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.cyanColor()

		scrollView = UIScrollView()
		view.addSubview(scrollView)
		scrollView.delegate = self

		contentView = UIView()
		contentView.backgroundColor = UIColor.blueColor()
		scrollView.addSubview(contentView)

		headerView = UIView()
		headerView.backgroundColor = UIColor.orangeColor()
	}


	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		scrollView.frame = view.bounds
		contentView.frame = scrollView.bounds
		contentView.frame.h = scrollView.bounds.height * 2

		// `y` is reset so that updates in contentOffset ocurr correctly
		contentView.frame.y = 0

		scrollView.contentSize = contentView.frame.size
		scrollView.contentInset.top = view.bounds.width
		scrollView.contentOffset.y = -view.bounds.width
	}


	func scrollViewDidScroll(scrollView: UIScrollView) {
//		debugPrint(scrollView.contentOffset)
	}


}