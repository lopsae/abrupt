import UIKit


class TestCollectionViewController:
	UICollectionViewController,
	UICollectionViewDelegateFlowLayout
{

	let cellIdentifier = "cellIdenfifier"

	init() {
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}


	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		self.collectionView?.registerClass(UICollectionViewCell.self,
			forCellWithReuseIdentifier: cellIdentifier)
		self.collectionView?.backgroundColor = UIColor.blueColor()
	}


	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}


	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 12
	}


	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(cellIdentifier,
			forIndexPath: indexPath)
		cell.backgroundView = UIView()
		cell.backgroundView?.backgroundColor = UIColor.brownColor()
		cell.selectedBackgroundView = UIView()
		cell.selectedBackgroundView?.backgroundColor = UIColor.redColor()
		return cell
	}


	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSize(width: 200, height: 200)
	}

}
