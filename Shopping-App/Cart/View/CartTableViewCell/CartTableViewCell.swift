//
//  CartTableViewCell.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import UIKit
import SDWebImage

class CartTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var cartContentView: UIView!
    @IBOutlet weak var cartProductImage: UIImageView!
    @IBOutlet weak var cartProductLabel: UILabel!
    @IBOutlet weak var cartProductPriceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var cartCountClosure: ((_ count: Int) -> Void)?
    var item: Item?
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToContentView()
    }

    // MARK: - Methods
    func configure(product: Item?) {
        cartProductLabel.text = product?.productName
        cartProductPriceLabel.text = "\(product?.price ?? 0.0)"
        cartProductImage.sd_setImage(with: URL(string: product?.icon ?? ""))
        quantityLabel.text = "\(String(describing: product?.cartItemCount ?? 0))"
        item = product
    }
    
    private func addShadowToContentView() {
        cartContentView.layer.masksToBounds = false
        cartContentView.layer.shadowColor = UIColor.gray.cgColor
        cartContentView.layer.shadowOpacity = 0.2
        cartContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cartContentView.layer.shadowRadius = 4
        cartContentView.layer.cornerRadius = 5
    }
    
    // MARK: - Button Actions
    @IBAction func minusButtonAction(_ sender: UIButton) {
        item?.cartItemCount -= 1
        cartCountClosure?(item?.cartItemCount ?? 0)
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        item?.cartItemCount += 1
        cartCountClosure?(item?.cartItemCount ?? 0)
    }
}
