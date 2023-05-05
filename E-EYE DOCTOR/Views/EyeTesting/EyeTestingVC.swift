import UIKit

class EyeTestingVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let ID = String(describing: EyeTestingVC.self)
    
    var testCellsCollectionView: UICollectionView?
    
    let cellImages = ["image1", "person", "image3", "image4"]
    let cellTitles = ["Test 1", "Test 2", "Test 3", "Test 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the collection view
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        testCellsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        testCellsCollectionView?.dataSource = self
        testCellsCollectionView?.delegate = self
        testCellsCollectionView?.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: "TestCell")
        testCellsCollectionView?.backgroundColor = .white
        if let collectionView = testCellsCollectionView {
            view.addSubview(collectionView)
        }
    }
    
        
        // Update the collection view layout
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Update the collection view layout
            if let collectionView = testCellsCollectionView,
               let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let width = collectionView.bounds.width / 2 - 10
                let height = width * 1.2
                layout.itemSize = CGSize(width: width, height: height)
            }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCollectionViewCell
        
        cell.testImageView.image = UIImage(named: cellImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle cell selection
    }
}
