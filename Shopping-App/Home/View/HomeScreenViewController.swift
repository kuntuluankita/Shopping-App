//
//  ViewController.swift
//  Shopping app
//
//  Created by Kuntulu Ankita on 08/05/24.
//

import UIKit
import CoreData

class HomeScreenViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var cartScreenButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var addCartItemView: UIView!
    @IBOutlet weak var addCartItemLabel: UILabel!
    
    
    var categoryArray: [Category] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientColor ()
        headerCornerRadius()
        collectionViewSetUp()
        addViewTapGesture()
        coreDataSetUp()
        topCartUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categoryCollectionView.reloadData()
        topCartUpdate()
    }
    
    // MARK: - Methods
    
    // MARK: Gradient Layer Setup
    func addGradientColor () {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = headerView.bounds
        
        // Set the colors for the gradient 
        gradientLayer.colors = [UIColor.systemYellow.cgColor, UIColor.systemOrange.cgColor]
        
        // Set the start and end points for the gradient
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        headerView.layer.insertSublayer(gradientLayer, at: 0)
        
        for subview in headerView.subviews {
            if subview != gradientLayer {
                subview.layer.zPosition = 1 // Set the zPosition to 1 to make sure it's above the gradient layer
            }
        }
        
    }
    
    // MARK: Header Corner Radius
    func headerCornerRadius() {
        let cornerRadius: CGFloat = 16
        let maskLayer = CAShapeLayer()
        categoryView.layer.cornerRadius = 10
        categoryCollectionView.showsVerticalScrollIndicator = false
        maskLayer.path = UIBezierPath(roundedRect: headerView.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        headerView.layer.mask = maskLayer
    }
    
    func topCartUpdate() {
        var totalItemCount = 0
        for category in categoryArray {
            for item in category.items ?? [] {
               totalItemCount += item.cartItemCount
            }
        }
        
        if totalItemCount <= 0 {
            addCartItemView.isHidden = true
        } else {
            addCartItemView.isHidden = false
            addCartItemLabel.text = "\(totalItemCount)"
            addCartItemView.layer.cornerRadius = 7
        }
    }
    
    // MARK: CollectionView Setup
    func collectionViewSetUp() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        categoryCollectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    }
    
    func addViewTapGesture() {
        // Add tap gesture recognizer to categoryView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(categoryViewTapped))
        categoryView.addGestureRecognizer(tapGesture)
    }
   
    // MARK: CoreData
    func isDataLoadedInCoreData() -> Bool {
        let fetchRequest: NSFetchRequest<CategoryModel> = CategoryModel.fetchRequest()
        do {
            // Execute fetch request
            let categories = try context.fetch(fetchRequest)
            // If there are any categories fetched, return true (data is already loaded)
            return !categories.isEmpty
        } catch {
            // Error occurred while fetching, return false (assume data is not loaded)
            print("Error fetching categories: \(error)")
            return false
        }
    }
    
    func loadToCoreData() {
        for item in categoryArray {
            let category = CategoryModel(context: context)
            category.id = Int64(item.id ?? 0)
            category.headerName = item.headerName
            category.isExpandable = item.isExpandable
            if let items = item.items {
                // Convert and add each ItemModel to the category
                for item in items {
                    let itemModel = ItemModel(context: context)
                    itemModel.id = Int64(item.id ?? 0)
                    itemModel.productName = item.productName
                    itemModel.icon = item.icon
                    itemModel.price = item.price ?? 0
                    itemModel.cartItemCount = Int64(item.cartItemCount)
                    itemModel.isFavorite = item.isFavorite
                    
                    // Add the item to the category's items set
                    category.addToItems(itemModel)
                }
            }
        }
        
        do {
            try context.save()
        } catch  {
            print("Error")
        }
    }
    
    func coreDataSetUp() {
        //Data load from Json
        JSONLoader.loadJSONData()
        self.categoryArray = MainProductViewModel.shared.categoryArray ?? []
        
        // Check if data is already loaded into Core Data
        if isDataLoadedInCoreData() {
            // Data is already loaded, no need to load again
            print("Data is already loaded into Core Data")
        } else {
            // Data is not loaded, proceed to load
            loadToCoreData()
        }
    }
    
    
    
    // MARK: - Button Actions
    @IBAction func favoriteButtonAction(_sender: UIButton) {
        if let favoriteVC = storyboard?.instantiateViewController(identifier: "FavoriteViewController") as? FavoriteViewController {
            navigationController?.pushViewController(favoriteVC, animated: true)
        }
        
    }
    
    @IBAction func cartButtonAction(_sender: UIButton) {
        if let cartVC = storyboard?.instantiateViewController(identifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    // MARK: ViewTap Action
    @objc func categoryViewTapped() {
        if let categoryVC = storyboard?.instantiateViewController(identifier: "CategoryViewController") as? CategoryViewController {
            //Hide category view
            self.categoryView.isHidden = true
            categoryVC.dismissClosure = {
                self.categoryView.isHidden = false
            }
            categoryVC.categoryArray = self.categoryArray
            categoryVC.view.backgroundColor = .black.withAlphaComponent(0.4)
            categoryVC.modalPresentationStyle = .overFullScreen
            categoryVC.modalTransitionStyle = .crossDissolve
            self.present(categoryVC, animated: true)
        }
    }
}

// MARK: - Extension
extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray[section].isExpandable ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell
        cell?.category = categoryArray[indexPath.section]
        cell?.addToCartClosure = {
            self.topCartUpdate()
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView
        let category = categoryArray[indexPath.section]
        header?.headerLabel.text = category.headerName
        header?.header = category
        header?.headerExpandableClosure = { [weak self] in
            self?.categoryCollectionView.reloadData()
        }
        return header ?? UICollectionReusableView()
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 50)
    }
    
}

