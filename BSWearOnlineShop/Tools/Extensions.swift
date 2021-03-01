//
//  Extensions.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 04.02.2021.
//

import Foundation
import UIKit


// MARK: - Extension String

extension String {
    func removeSymbols() -> String {
        return self.replacingOccurrences(of: "&nbsp;", with: " ").replacingOccurrences(of: "&amp;", with: " ")
    }
    
    func priceToRUB() -> String {
        return self.split(separator: ".")[0] + " ₽"
    }
}


// MARK: - Extension UIView

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}
// MARK: - Extension Numeric + Formatter

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String {Formatter.withSeparator.string(for: self) ?? ""}
}
// MARK: - UITableView
extension UITableView {
    func showMessageIfBasketEmpty(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func updateTable() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
