//
//  UILabel+Extensions.swift
//  Neostore
//
//  Created by webwerks1 on 20/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    func setCorner()
    {
        //self.backgroundColor = .clear
        self.layer.cornerRadius = 13
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.masksToBounds = true
        self.layer.backgroundColor = UIColor.red.cgColor
        self.textColor = UIColor.white
        
    }
    
}
