//
//  CategoryViewController.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 14.01.2021.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    var categories = [Categories]()
    var subcategories = [Subcategory]()
    var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        getCategories()
        tableView.tableFooterView = UIView()

    }

    // MARK: - Get categories from url to show in table
    func getCategories() {
        NetworkManager().loadDataFromURL(urlString: URLs().getCatURL()!, type: Categories.self) {
            (data) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.categories = data
                self.tableView.reloadData()
            }
        }
    }
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
   

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath) as! CategoryTableViewCell
        let category = categories[indexPath.row]
        ImageLoader.shared.loadImage(imagePath: URLs().blackStarURL + "\(category.image)") { (image) in
            cell.categoryImageView.image = image}
        cell.setCategoryCell(category: category)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showSubcategory", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let subcategoriesController = segue.destination as? SubcategoryViewController, segue.identifier == "showSubcategory" {
            subcategoriesController.subcategories = categories[selectedRow].subcategories

        }
        
    }
    
}
