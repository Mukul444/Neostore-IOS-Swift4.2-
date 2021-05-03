//
//  StoreLocatorTableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 05/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class StoreLocatorTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationDiscriptionLabel: UILabel!
    
    //MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
