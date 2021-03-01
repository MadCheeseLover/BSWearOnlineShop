//
//  CoreDataManager.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 13.02.2021.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    // MARK: -  Methods to Store and Fetch data
  
    func saveData(product: Product, size: String, image: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ProductCard", in: managedContext) else {return}
        let productCard = ProductCard(entity: entity, insertInto: managedContext)
        let image = image.jpegData(compressionQuality: 0.75)
        productCard.name = product.name
        productCard.mainImage = image
        productCard.colorName = product.colorName
        productCard.price = product.price
        productCard.size = size
        
        do {
            try managedContext.save()
            
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchData() -> [ProductCard] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ProductCard>(entityName: "ProductCard")
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteData(product: ProductCard) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(product)
        do {
            try managedContext.save()
            
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func deleteAll(product: [ProductCard]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCard")

        fetchRequest.includesPropertyValues = false

        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()

        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        }

  }




