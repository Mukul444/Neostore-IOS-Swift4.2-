//
//  AddressListTableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 14/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var checkBtn : UIButton!
    
    //MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
         checkBtn.layer.cornerRadius = 12.5
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
