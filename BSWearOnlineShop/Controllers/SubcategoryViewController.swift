//
//  SubcategoryViewController.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 21.01.2021.
//

import UIKit

class SubcategoryViewController: UITableViewController {
    
    var subcategories = [Subcategory]()
    var categories = [Categories]()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupDelegates()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        
        
    }
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subcategories.count == 0 {
            self.tableView.showMessageIfBasketEmpty("Товары в данной категории отсутствуют")
        } else {
            self.tableView.updateTable()
        }
        return subcategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subcategory", for: indexPath) as! SubcategoryTableViewCell
        let subcategory = subcategories[indexPath.row].name
        cell.subcategoryLabel.text = subcategory
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showProductList", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productListController = segue.destination as? ProductListCollectionViewController,
           segue.identifier == "showProductList" {
            productListController.subcategoryID = subcategories[selectedRow].id
            productListController.subcategoryName = subcategories[selectedRow].name
        }
        
    }
}
