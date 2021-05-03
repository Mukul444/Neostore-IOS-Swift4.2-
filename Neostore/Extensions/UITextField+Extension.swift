//
//  Textfields.swift
//  Neostore
//
//  Created by webwerks1 on 26/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = UIColor.white
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        
    }
}
