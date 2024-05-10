//
//  FavoriteTableViewCell.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var favoriteContentView: UIView!
    @IBOutlet weak var favoriteProductImage: UIImageView!
    @IBOutlet weak var favoriteProductLabel: UILabel!
    @IBOutlet weak var favoriteProductPriceLabel: UILabel!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var favoriteProductFavoriteButton: UIButton!
    
    var favClosure: (() -> Void)?
    var item: Item?
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToContentView()
    }
    
    // MARK: - Methods
    func configure(product: Item?) {
        favoriteProductLabel.text = product?.productName
        favoriteProductPriceLabel.text = "\(product?.price ?? 0.0)"
        favoriteProductImage.sd_setImage(with: URL(string: product?.icon ?? ""))
        item = product
    }
    
    private func addShadowToContentView() {
        favoriteContentView.layer.masksToBounds = false
        favoriteContentView.layer.shadowColor = UIColor.gray.cgColor
        favoriteContentView.layer.shadowOpacity = 0.2
        favoriteContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        favoriteContentView.layer.shadowRadius = 4
        favoriteContentView.layer.cornerRadius = 5
    }
   
    // MARK: - Button Actions
    @IBAction func quantityButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        item?.isFavorite = false
        favClosure?()
    }
}
