//
//  HeaderCollectionReusableView.swift
//  Shopping app
//
//  Created by Kuntulu Ankita on 08/05/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    // MARK: - Properties
    @IBOutlet weak var headerLabel: UILabel!
    
    var header: Category?
    var headerExpandableClosure: (() -> Void)?
  
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Button Action
    @IBAction func categoryExpandButton(_ sender: UIButton) {
        // Toggle the header
        header?.isExpandable.toggle()
        if let headerClosure = headerExpandableClosure {
            headerClosure()
        }
    }
}
