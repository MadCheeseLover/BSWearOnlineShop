//
//  SizePopUpViewController.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 12.02.2021.
//

import UIKit

protocol SizePopUpViewControllerDelegate {
    func selectedSize(data: Product, size: String)
}
class SizePopUpViewController: UIViewController {
    var data: Product?
    var delegate: SizePopUpViewControllerDelegate?

    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var roundedSmallView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        roundedView.roundCorners([.topLeft, .topRight], radius: 22)
        roundedSmallView.roundCorners(.allCorners, radius: 22)
     
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension SizePopUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.offers.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizePopUpTableViewCell
        cell.sizeLabel.text = data?.offers[indexPath.row].size
        cell.checkmarkImage.image = nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedSize(data: data!, size: data?.offers[indexPath.row].size ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
       
        if let cell = tableView.cellForRow(at: indexPath) as? SizePopUpTableViewCell {
            cell.checkmarkImage.image = UIImage(named: "checkmark1")
        }
      
    }
    
}
