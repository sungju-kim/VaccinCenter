//
//  UIFont + extension.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/07.
//

import UIKit.UIFont

extension UIFont {
    class func customFont(ofSize: CGFloat, weight: CustomWeight) -> UIFont? {
        return UIFont(name: weight.name, size: ofSize)
    }

    enum CustomWeight: String {
        case medium = "Medium"
        case regular = "Regular"
        case semibold = "Semibold"
        case bold = "Bold"

        private var fontName: String {
            return "SFProDisplay"
        }

        private var weight: String {
            return rawValue
        }

        var name: String {
            return "\(fontName)-\(weight)"
        }
    }
}
