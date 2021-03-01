//
//  ProductCardViewController.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 31.01.2021.
//

import UIKit

class ProductCardViewController: UIViewController {
    
    
    var product: Product?
    var productImages = [UIImage]()
    var sizePopUpVC = SizePopUpViewController()
    var imageToData: UIImage?
   


    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nameOfProduct: UILabel!
    @IBOutlet weak var priceOfProduct: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
 
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet weak var addToBusketButtonOutlet: UIButton!
    
    @IBOutlet weak var sizeContainerView: UIView!
    
    
    
    @IBAction func addToBusketButton(_ sender: UIButton) {
        AddToBasketButtonAnimation().shake(button: addToBusketButtonOutlet)
        sizeContainerView.isHidden = false
        sizeContainerView.frame = self.view.frame
        SizeViewAnimation.moveIn(sizeContainerView)
        saveImageToData()
      
       
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
        self.view.addGestureRecognizer(panGesture)
    }

    // MARK: - Saving image to show in basket (first image of collection)
    func saveImageToData() {
        if productImages.isEmpty {
            imageToData = UIImage(named: "placeholder")
        } else {
            imageToData = productImages[0]
        }
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeContainerView.isHidden = true
        customizeButton()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sizeContainerView", let destination = segue.destination as? SizePopUpViewController {
            self.sizePopUpVC = destination
            guard let product = product else {return}
            self.sizePopUpVC.data = product
            self.sizePopUpVC.delegate = self
            
        }
    }
    func setupView() {
        guard let productData = product else {return}
        nameOfProduct.text = productData.name.removeSymbols()
        priceOfProduct.text = productData.price.priceToRUB()
        colorLabel.text = productData.colorName
        descriptionLabel.text = productData.description.removeSymbols()
        
        guard let productUrl = product?.productImages else {return}
        productImages = loadProductImages(images: productUrl)
        pageControl.numberOfPages = productImages.count
    }
    
    func customizeButton() {
        addToBusketButtonOutlet.layer.cornerRadius = 10
        addToBusketButtonOutlet.layer.shadowOpacity = 0.8
        addToBusketButtonOutlet.layer.shadowRadius = 2.0
        addToBusketButtonOutlet.layer.shadowOffset = CGSize(width: 1.5, height: 2)
        addToBusketButtonOutlet.layer.shadowColor = UIColor.gray.cgColor
    }

    // MARK: - Swipe down of Size Pop UP VC
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {

        if sender.state == .ended {
            SizeViewAnimation.moveOut(sizeContainerView)

        }

    }
    
}


extension ProductCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCardCell", for: indexPath) as! ProductCardCollectionViewCell
        cell.productImages.image = productImages[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func loadProductImages(images: [WearImage]) -> [UIImage] {
        var imagesArray = [UIImage]()
        
        for i in images {
            let url = URLs().blackStarURL + "\(i.imageURL)"
            if let imageURL = URL(string: url),
               let imageData = try? Data(contentsOf: imageURL),
               let image = UIImage(data: imageData) {
                
                imagesArray.append(image)
            }
        }
        return imagesArray
    }
    
}
extension ProductCardViewController: SizePopUpViewControllerDelegate {
    func selectedSize(data: Product, size: String) {
        
        SizeViewAnimation.moveOut(sizeContainerView)
        addToBusketButtonOutlet.backgroundColor = #colorLiteral(red: 0.3249462, green: 0.7942924885, blue: 0.3258542448, alpha: 0.9)
        addToBusketButtonOutlet.setTitle("Добавлено в корзину", for: .normal)
        AddToBasketButtonAnimation().increase(button: addToBusketButtonOutlet)
        
        guard let image = imageToData ?? UIImage(named: "placeholder") else {return}
        CoreDataManager.shared.saveData(product: data, size: size, image: image)        
    }
}

