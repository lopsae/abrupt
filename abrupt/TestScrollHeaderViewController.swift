import UIKit

class TestScrollHeaderViewController: UIViewController,
	UIScrollViewDelegate
{

	var scrollView: UIScrollView!
	var contentView: UIView!
	var headerView: DynamicScrollHeaderView!

	var firstLayout = true

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.cyan

		contentView = UIView()
		contentView.backgroundColor = UIColor.blue

		scrollView = UIScrollView()
		view.addSubview(scrollView)
		scrollView.delegate = self
		scrollView.addSubview(contentView)

		let nibObjects = Bundle.main.loadNibNamed("DynamicScrollHeaderView", owner: nil, options: nil)
		headerView = nibObjects!.first as! DynamicScrollHeaderView
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


	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let minHeaderHeight:CGFloat = 80
		headerView.frame.h = cgclamp(-scrollView.contentOffset.y,
			max: view.bounds.width,
			min: minHeaderHeight)
//		debugPrint(scrollView.contentOffset)
	}


}
