//
//  UIImageView+Extensions.swift
//  Neostore
//
//  Created by webwerks1 on 22/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func setCorner(radius:CGFloat)
    {
        //self.backgroundColor = .clear
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 3
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        
    }
    
}
