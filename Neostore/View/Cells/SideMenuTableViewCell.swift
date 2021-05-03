//
//  SideMenuTableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 25/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import KeychainSwift

class SideMenuTableViewCell: UITableViewCell {

    
    // MARK:- IBOutlets
    @IBOutlet weak var sideImageView: UIImageView!
    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var cartItemLabel: UILabel!
    
    // MARK:- Vaiables
    var keychain = KeychainSwift()
    
    // MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        cartItemLabel.setCorner()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
