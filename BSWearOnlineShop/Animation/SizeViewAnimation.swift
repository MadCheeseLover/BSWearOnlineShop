//
//  SizeViewAnimation.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 10.02.2021.
//


import UIKit
struct SizeViewAnimation {
    static func moveIn(_ view: UIView) {
        view.frame = CGRect(x: view.frame.origin.x, y: (view.superview?.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height)
        
        UIView.animate(withDuration: 0.5, animations: {view.center = view.superview!.center})
                
    }
    static func moveOut(_ view: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 300)
            view.isHidden = true
        }, completion: nil)
    }

}
