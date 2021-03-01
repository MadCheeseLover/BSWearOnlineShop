//
//  AddToBasketButtonAnimation.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 13.02.2021.
//

import Foundation
import UIKit

class AddToBasketButtonAnimation: UIButton {

        func shake(button: UIButton) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    func increase(button: UIButton) {
    UIView.animate(withDuration: 0.6,
        animations: {
            button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
            button.transform = CGAffineTransform.identity
            }
        })
    }
}

