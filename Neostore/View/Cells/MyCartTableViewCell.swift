//
//  MyCartTableViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 14/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import DropDown

protocol EditCartDelegate{
    func relodTableData(myCartDetails : ListCartResponse)
}
class MyCartTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    //MARK:- Variables
    var menu  = DropDown()
    var poductId = 1
    var editCartResponseData : AddToCartResponse?
    var myCartDetails : ListCartResponse?
    var editCartDelegate : EditCartDelegate?
    
    //MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupDropDown()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupDropDown(){
        menu.dataSource = MyCartViewModel.numArray
        menu.anchorView = dropDownView
        menu.selectionAction = {index,title in
            self.quantityLabel.text = title
           self.callApi()
        }
    }
    
    func callApi()
    {
        let myCartViewModel = MyCartViewModel()
        myCartViewModel.editCart(product_id: String(poductId), quantity: Int(quantityLabel!.text!)!){data in
            DispatchQueue.main.async {
                if (data.status == 200){
                    self.editCartResponseData = data
                    myCartViewModel.listCart{data in
                        DispatchQueue.main.async {
                            if (data.status == 200){
                                self.myCartDetails = data
                                self.editCartDelegate!.relodTableData(myCartDetails : self.myCartDetails!)
                            }
                        }
                    }
                }
                //print("Successfully ADDED TO CART  ")
            }
        }
    }
    
    //MARK:- IBActions
    @IBAction func didTapDropDownBtn(_ sender: UIButton)
    {
        menu.show()
    }
}
