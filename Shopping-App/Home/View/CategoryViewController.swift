//
//  CategoryViewController.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import UIKit

class CategoryViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var categoryArray: [Category] = []
    var dismissClosure: (() -> Void)?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIewSetup()
    }
    
    // MARK: Button Actions
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        dismissClosure?()
        self.dismiss(animated: true)
    }
    
    // MARK: - Methods
    func tableVIewSetup() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.separatorStyle = .none
        categoryView.layer.cornerRadius = 8
    }
    
}

// MARK: - Extension
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell
        cell?.categoryLabel.text = categoryArray[indexPath.row].headerName
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}
