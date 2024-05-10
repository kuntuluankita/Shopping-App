//
//  FavoriteViewController.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var favoriteScreenBackButton: UIButton!
    @IBOutlet weak var favoriteProductTableView: UITableView!
    
    var viewModel = FavoritesViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableViewSetup()
    }
    
    // MARK: - Methods
    func favoriteTableViewSetup() {
        favoriteProductTableView.dataSource = self
        favoriteProductTableView.delegate = self
        favoriteProductTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        navigationController?.setNavigationBarHidden(true, animated: false)
        favoriteProductTableView.separatorStyle = .none
        favoriteProductTableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Button Actions
    @IBAction func backButtonAction(_sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Extensions
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFavoriteArray()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell
        cell?.configure(product: viewModel.getFavoriteArray()?[indexPath.row])
        cell?.favClosure = {
            self.favoriteProductTableView.reloadData()
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
