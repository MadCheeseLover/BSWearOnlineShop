//
//  ProductListCollectionViewController.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 28.01.2021.
//

import UIKit

private let reuseIdentifier = "Product"

class ProductListCollectionViewController: UICollectionViewController {
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var subcategoryID: ID?
    var subcategoryName: String?
    var productList = [Product]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductList()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductListCollectionViewCell
        ImageLoader.shared.loadImage(imagePath: URLs().blackStarURL + "\(productList[indexPath.row].mainImage)") { (image) in
            cell.productImageView.image = image}
        cell.productImageView.contentMode = .scaleAspectFit
        cell.nameProductLabel.text = productList[indexPath.row].name
        cell.priceLabel.text = productList[indexPath.row].price.priceToRUB()
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "showProductCard", sender: productList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productCardController = segue.destination as? ProductCardViewController,
           segue.identifier == "showProductCard", let product = sender as? Product {
            productCardController.product = product
        }
         
    }

}

// MARK: UICollectionViewDelegate
extension ProductListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let interItemSpacing: CGFloat = 20
        let labelSrackHeight: CGFloat = 41
        let edgeInsetsSum: CGFloat = 40
        let width = (collectionView.frame.width - edgeInsetsSum - (numberOfItemsPerRow - 1) * interItemSpacing) / numberOfItemsPerRow
        let height = width + labelSrackHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
    
}

// MARK: - Get list of product by subcategory ID
extension ProductListCollectionViewController {
    
    func getProductList() {
        guard let subcategoryID = subcategoryID else {return}
        NetworkManager().loadDataFromURL(urlString: URLs().getProductURLFromID(subcategoryID: subcategoryID)!, type: Product.self) { (data) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.productList = data
                self.collectionView.reloadData()
            }
        }
    }
}

