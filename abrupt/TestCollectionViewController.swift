import UIKit


class TestCollectionViewController:
	UICollectionViewController,
	UICollectionViewDelegateFlowLayout
{

	let cellIdentifier = "cellIdentifier"

	init() {
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}


	required init?(coder: NSCoder) {
	    fatalError("init(coder:) is not implemented")
	}


	override func viewDidLoad() {
		self.collectionView?.registerClass(UICollectionViewCell.self,
			forCellWithReuseIdentifier: cellIdentifier)
		self.collectionView?.backgroundColor = UIColor.brownColor().lighten(0.5)
	}


	override func numberOfSectionsInCollectionView(
		collectionView: UICollectionView)
		-> Int
	{
		return 2
	}


	override func collectionView(
		collectionView: UICollectionView,
		numberOfItemsInSection section: Int)
		-> Int
	{
		return 7
	}


	override func collectionView(
		collectionView: UICollectionView,
		cellForItemAtIndexPath indexPath: NSIndexPath)
		-> UICollectionViewCell
	{
		let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(cellIdentifier,
			forIndexPath: indexPath)
		cell.backgroundView = UIView()
		cell.backgroundView?.backgroundColor = UIColor.brownColor().lighten(0.3)
		cell.selectedBackgroundView = UIView()
		cell.selectedBackgroundView?.backgroundColor = UIColor.brownColor().darken(0.1)
		return cell
	}


	func collectionView(
		collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAtIndexPath indexPath: NSIndexPath)
		-> CGSize
	{
		return CGSize(width: 200, height: 100)
	}


	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
	}

}
