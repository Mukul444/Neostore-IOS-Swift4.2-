//
//  TableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 26/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class ProductListViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productManufacturer: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet  var productRating: [UIImageView]!
    
    //MARK:- ViewLifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
