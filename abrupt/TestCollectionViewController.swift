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
		collectionView?.registerClass(UICollectionViewCell.self,
			forCellWithReuseIdentifier: cellIdentifier)
		collectionView?.backgroundColor = UIColor.brownColor().lighten(0.5)
		collectionView?.allowsMultipleSelection = true

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


	/// This method only gets called by user taps in the UI. Calling
	/// `collectionView.selectItemAtIndexPath` does not trigger a call to this
	/// method.
	override func collectionView(collectionView: UICollectionView,
		didSelectItemAtIndexPath indexPath: NSIndexPath)
	{
		var pairedIndexPath = indexPath.indexPathByRemovingLastIndex()
		if indexPath.row % 2 == 0 {
			pairedIndexPath = pairedIndexPath.indexPathByAddingIndex(indexPath.row + 1)
		} else {
			pairedIndexPath = pairedIndexPath.indexPathByAddingIndex(indexPath.row - 1)
		}
		collectionView.selectItemAtIndexPath(pairedIndexPath,
			animated: true,
			scrollPosition: .None)
	}


	override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
		var pairedIndexPath = indexPath.indexPathByRemovingLastIndex()
		if indexPath.row % 2 == 0 {
			pairedIndexPath = pairedIndexPath.indexPathByAddingIndex(indexPath.row + 1)
		} else {
			pairedIndexPath = pairedIndexPath.indexPathByAddingIndex(indexPath.row - 1)
		}
		collectionView.deselectItemAtIndexPath(pairedIndexPath,
			animated: true)
	}

}
