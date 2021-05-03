//
//  MyOrderTableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 02/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
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
