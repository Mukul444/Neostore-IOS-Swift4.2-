//
//  OrderIDTableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 02/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class OrderIDTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
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
