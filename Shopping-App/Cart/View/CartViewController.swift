//
//  CartViewController.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var billView: UIView!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var subTotalPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var viewModel = CartViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableViewSetUp()
        updateBillView()
        cornerRadius()
        
    }
    
    // MARK: - Methods
    func updateBillView() {
        subTotalPriceLabel.text = String(format: "%.2f", viewModel.calculateTotalPrice())
        discountPriceLabel.text = "0"
        totalPriceLabel.text = String(format: "%.2f", viewModel.calculateTotalPrice())
        
        if viewModel.calculateTotalPrice() == 0.0 {
            billView.isHidden = true
        } else {
            billView.isHidden = false
        }
    }
    
    func cartTableViewSetUp() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        navigationController?.setNavigationBarHidden(true, animated: false)
        cartTableView.separatorStyle = .none
        cartTableView.showsVerticalScrollIndicator = false
    }
    
    func cornerRadius() {
        billView.layer.cornerRadius = 20
        checkOutButton.layer.cornerRadius = 5
    }
    
    // MARK: - Button Actions
    @IBAction func cartBackButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func checkOutButtonAction(_ sender: UIButton) {
    }
    
}

// MARK: - Extensions
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCartArray()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell
        cell?.configure(product: viewModel.getCartArray()?[indexPath.row])
        cell?.cartCountClosure = { cartCount in
            self.cartTableView.reloadData()
            self.updateBillView()
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    
}

