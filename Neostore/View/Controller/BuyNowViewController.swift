//
//  BuyNowViewController.swift
//  Neostore
//
//  Created by webwerks1 on 16/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import KeychainSwift

class BuyNowViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productQuantityTextField: UITextField!
    @IBOutlet weak var BuyNowBtn: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    //MARK:- Variables
    var productNameData : String?
    var productImageData : UIImage?
    var quantity  = 1
    var productId  = 1
    var buyNowResponse : AddToCartResponse?
    let keychain = KeychainSwift()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        productName.text = productNameData
        productImageView.image = productImageData
        BuyNowBtn.setCorner()
    }
    
    //MARK:- IBAction
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapBuyNow(_ sender: Any) {
        quantity = Int(productQuantityTextField.text ?? String(1))!
        let buyNowViewModel = BuyNowViewModel()
        buyNowViewModel.addToCart(product_id: String(productId), quantity: quantity){data,bool in
            if(bool)
            {
                Alert.failPopUp(message: STRING.failedToAddCart, viweControler: self)
            }
            else{
                DispatchQueue.main.async {
                    if (data?.status == 200){
                        self.buyNowResponse = data
                        self.keychain.set("\(data?.totalCarts! ?? 0)", forKey: STRING.totalCarts)
                        Alert.alertPopUp(identifier: nil, message: STRING.addedToCart, actionEnum: .dismiss, viewController: self)
                    }
                   // print("Successfully ADDED TO CART  ")
                }
            }
        }
    }
}
