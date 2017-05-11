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
		collectionView?.register(UICollectionViewCell.self,
			forCellWithReuseIdentifier: cellIdentifier)
		collectionView?.backgroundColor = UIColor.brown.lighten(0.5)
		collectionView?.allowsMultipleSelection = true

	}


	override func numberOfSections(
		in collectionView: UICollectionView)
		-> Int
	{
		return 2
	}


	override func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int)
		-> Int
	{
		return 7
	}


	override func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath)
		-> UICollectionViewCell
	{
		let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
			for: indexPath)
		cell.backgroundView = UIView()
		cell.backgroundView?.backgroundColor = UIColor.brown.lighten(0.3)
		cell.selectedBackgroundView = UIView()
		cell.selectedBackgroundView?.backgroundColor = UIColor.brown.darken(0.1)
		return cell
	}


	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath)
		-> CGSize
	{
		return CGSize(width: 200, height: 100)
	}


	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
	}


	/// This method only gets called by user taps in the UI. Calling
	/// `collectionView.selectItemAtIndexPath` does not trigger a call to this
	/// method.
	override func collectionView(_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath)
	{

		var pairedIndexPath = indexPath
		pairedIndexPath.removeLast()
		if indexPath.row % 2 == 0 {
			pairedIndexPath.append(indexPath.row + 1)
		} else {
			pairedIndexPath.append(indexPath.row - 1)
		}
		collectionView.selectItem(at: pairedIndexPath,
			animated: true,
			scrollPosition: UICollectionViewScrollPosition())
	}


	override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		var pairedIndexPath = indexPath
		pairedIndexPath.removeLast()
		if indexPath.row % 2 == 0 {
			pairedIndexPath.append(indexPath.row + 1)
		} else {
			pairedIndexPath.append(indexPath.row - 1)
		}
		collectionView.deselectItem(at: pairedIndexPath,
			animated: true)
	}

}
