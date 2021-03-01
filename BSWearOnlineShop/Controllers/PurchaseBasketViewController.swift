//
//  PurchaseBasketViewController.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 30.01.2021.
//

import UIKit

class PurchaseBasketViewController: UIViewController {
    var products = [ProductCard]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var totalCostLabel: UILabel!
    
 
    @IBAction func checkoutButtonAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Упс...", message: "Что-то пошло не так", preferredStyle: .alert)
        let pressOK = UIAlertAction(title: "Ок", style: .default) { _ in}
        alertController.addAction(pressOK)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteAllProducts(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Очистить корзину?", message: "Все товары корзины будут удалены.", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Удалить", style: .destructive, handler: {action in
            self.products.removeAll()
            self.tableView.reloadData()
            CoreDataManager.shared.deleteAll(product: self.products)
            self.totalCostLabel.text = "\(Int((self.getTotalCost()))) ₽"
        })
        let cancel = UIAlertAction(title: "Отмена", style: .default) { _ in}
        alertController.addAction(delete)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let productsFromDB = CoreDataManager.shared.fetchData()
        products = productsFromDB
        getCountOfProducts()
        
        let totalCost = Int(getTotalCost())
        totalCostLabel.text = "\(totalCost.formattedWithSeparator) ₽"
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.layer.cornerRadius = 15
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    // MARK: - Get count of items to show on tab bar
    func getCountOfProducts() {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            tabItem.badgeValue = "\(products.count)"
        }
    }

    func getTotalCost() -> Float {
        var sum: Float =  0
        for i in products {
            if let pr = Float(i.price ?? "0") {
                sum += pr
            }
        }
        return sum
        
    }
    
}

// MARK: - if there is no products return message
extension PurchaseBasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            self.tableView.showMessageIfBasketEmpty("В вашей корзине пока нет товаров :(")
        } else {
            self.tableView.updateTable()
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell") as! BasketTableViewCell
        let productCard = products[indexPath.row]
        cell.nameLabel.text = productCard.name
        cell.colorLabel.text = productCard.colorName
        cell.priceLabel.text = productCard.price?.priceToRUB()
        cell.sizeLabel.text = productCard.size
        
        if let image = productCard.mainImage {
            cell.productImage.image = UIImage(data: image)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteData(product: products[indexPath.row])
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            totalCostLabel.text = "\(Int((getTotalCost()))) ₽"
            getCountOfProducts()
            
        }
        
    }
}
