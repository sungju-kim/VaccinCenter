//
//  UIButton + extension.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/07.
//

import UIKit.UIButton

extension UIButton {
    func insertPadding(top: CGFloat = Constraint.semiRegular,
                       leading: CGFloat = Constraint.semiRegular,
                       bottom: CGFloat = Constraint.semiRegular,
                       trailing: CGFloat = Constraint.semiRegular) {

        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .init(top: top,
                                                leading: leading,
                                                bottom: bottom,
                                                trailing: trailing)

            self.configuration = configuration
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: top,
                                                    left: leading,
                                                    bottom: bottom,
                                                    right: trailing)
        }
    }
}
