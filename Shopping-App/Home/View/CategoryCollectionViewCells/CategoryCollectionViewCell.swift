//
//  CategoryCollectionViewCell.swift
//  Shopping app
//
//  Created by Kuntulu Ankita on 08/05/24.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    @IBOutlet weak var productCollectionView: UICollectionView!
    var addToCartClosure: (() -> Void)?
    
    var category: Category? {
        didSet {
            productCollectionView.reloadData() // Update the collection view when the category is set
        }
    }
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        productCollectionViewSetup()
    }
    
    // MARK: - Methods
    func productCollectionViewSetup() {
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        productCollectionView.showsHorizontalScrollIndicator = false
    }

}

// MARK: - Extensions
extension CategoryCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell
        cell?.configure(product: category?.items?[indexPath.row])
        cell?.addToCartClosure = {
            self.addToCartClosure?()
        }
        return cell ?? UICollectionViewCell()
    }
}

extension CategoryCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
}

