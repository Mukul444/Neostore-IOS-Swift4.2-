//
//  RateViewController.swift
//  Neostore
//  thanks Xcode
//  Created by webwerks1 on 16/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit


class RateViewController: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet var rating : [UIButton]!
    @IBOutlet weak var rateNowBtn: UIButton!
    
    // MARK:- Variables
    var ratingResponse : RatingResponse?
    var productNameData : String?
    var productImageData : UIImage?
    var productId : Int = 1
    var rate : Int = 1
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    func SetupUI()
    {
        productName.text = productNameData
        productImage.image = productImageData
        rateNowBtn.setCorner()
    }
    
    //MARK:- IBActions
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnStarBtn(_ sender: UIButton) {
        
        rate = sender.tag
        for btn in rating{
            if(btn.tag <= sender.tag)
            {
                btn.setImage(UIImage(named: IMAGE.star_check), for: .normal)
            }
            else
            {
                btn.setImage(UIImage(named: IMAGE.star_unchek), for: .normal)
            }
        }
    }
    
    @IBAction func didTapRateNow(_ sender: Any)
    {
        let rateViewModel = RateViewModel()
        rateViewModel.setRating(product_id: String(productId), rate: rate){data,bool in
            if(bool){
             Alert.failPopUp(message: STRING.failedToRate , viweControler: self)
            }
            else{
                DispatchQueue.main.async {
                    if (data?.status == 200){
                        self.ratingResponse = data
                        Alert.alertPopUp(identifier: nil, message:STRING.ratedSuccessfully , actionEnum: .dismiss, viewController: self)
                    }
                }
            }
        }
    }
}
