//
//  CategoryTableViewCell.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 14.01.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
 
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func setCategoryCell(category: Categories) {
        categoryLabel.text = category.name
        categoryLabel.textAlignment = .left
    }

}
