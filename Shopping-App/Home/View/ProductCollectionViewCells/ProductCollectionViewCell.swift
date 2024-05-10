//
//  ProductCollectionViewCell.swift
//  Shopping app
//
//  Created by Kuntulu Ankita on 08/05/24.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var wishListButton: UIButton!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productView: UIView!
    var item: Item?
    var addToCartClosure: (() -> Void)?
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToContentView()
    }
   
    
    // MARK: - Methods
    func configure(product: Item?) {
        productNameLabel.text = product?.productName
        priceLabel.text = "\(String(describing: product?.price ?? 0.0))"
        productImageView.sd_setImage(with: URL(string: product?.icon ?? ""))
        item = product
        updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        if item?.isFavorite ?? false{
            wishListButton.setImage(UIImage(named: "wishlist"), for: .normal)
        } else {
            wishListButton.setImage(UIImage(named: "not_wishlist"), for: .normal)
        }
    }
    
    private func addShadowToContentView() {
        productView.layer.masksToBounds = false
        productView.layer.shadowColor = UIColor.gray.cgColor
        productView.layer.shadowOpacity = 0.2
        productView.layer.shadowOffset = CGSize(width: 0, height: 2)
        productView.layer.shadowRadius = 4
        productView.layer.cornerRadius = 8
    }
    
    // MARK: - Button Actions
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        item?.isFavorite.toggle()
        CoredataManager.shared.updateCoreDataCategories(with: MainProductViewModel.shared.categoryArray ?? [])
        updateFavoriteButton()
    }
    
    @IBAction func addToCarrtButtonAction(_ sender: UIButton) {
        item?.cartItemCount += 1
        CoredataManager.shared.updateCoreDataCategories(with: MainProductViewModel.shared.categoryArray ?? [])
        self.addToCartClosure?()
    }
}
