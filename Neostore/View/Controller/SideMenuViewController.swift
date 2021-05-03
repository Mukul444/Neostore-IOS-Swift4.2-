//
//  SideMenuViewController.swift
//  Neostore
//
//  Created by webwerks1 on 25/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import KeychainSwift

class SideMenuViewController: UIViewController{
    //MARK:- IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emaiLabel: UILabel!
    
    //MARK:- VARIABLES
    var productId : Int = 1
    var myAccountDetails : GetUserData?
    var myCartDetails : ListCartResponse?
    var orderListResponse : OrderListResponse?
    var cartCount : String = String(0)
    var productList : ProductList?
    var keychain = KeychainSwift()
    let optionsArray = SideMenuViewModel.menuArray
    let optionIconsArray = SideMenuViewModel.menuIcons
    
    //MARK:- LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func setupUI(){
        profilePicImageView.setCorner(radius: 41.66)
        if (keychain.get(STRING.profile_pic) != nil){
            profilePicImageView.image = UIImage().getImageFromUrl(picUrl: keychain.get(STRING.profile_pic)!)
        }
        else{
            profilePicImageView.image = UIImage(named : IMAGE.user_male)
        }
        userName.text = "\(keychain.get(STRING.first_name)!) \(keychain.get(STRING.last_name)!)"
        emaiLabel.text = keychain.get(STRING.email)
        guard let cartCount1 = keychain.get(STRING.totalCarts)else{return}
        cartCount = cartCount1
        tableView.reloadData()
    }
}

// MARK:- TABLEVIEW DELEGATES
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.row == 0){
            let myCartViewModel = MyCartViewModel()
            myCartViewModel.listCart{data in
                DispatchQueue.main.async {
                    if (data.status == 200){
                        
                        self.myCartDetails = data
                        self.performSegue(withIdentifier: STRING.goToMyCart, sender: self)
                    }
                }
            }
        }
        else if(indexPath.row == 1){
            productId = 1
        }
        else if(indexPath.row == 3){
            productId = 2
        }
        else if(indexPath.row == 2){
            productId = 3
        }
        else if(indexPath.row == 4){
            productId = 4
        }
        else if(indexPath.row == 5){
            let myAccountViewModel = MyAccountViewModel()
            myAccountViewModel.getUserDetails{data in
                DispatchQueue.main.async {
                    if (data.status == 200){
                        self.myAccountDetails = data
                        self.performSegue(withIdentifier: STRING.goToMyAccount, sender: self)
                        //print("Successfully Updated MY ACCOUNT details ")
                    }
                }
            }
        }
        else if(indexPath.row == 6){
            performSegue(withIdentifier: STRING.goToStoreLocator, sender: self)
        }
        else if(indexPath.row == 7){
            let orderListViewModel = OrderListViewModel()
            orderListViewModel.listOrder{data in
                DispatchQueue.main.async {
                    if (data.status == 200){
                        
                        self.orderListResponse = data
                        self.performSegue(withIdentifier: STRING.goToMyOrders, sender: self)
                        
                    }
                   // print("Successfully Listed My Cart Product ")
                }
            }
            
        }
        else if(indexPath.row == 8){
            performSegue(withIdentifier: STRING.goToAddressListMenu, sender: self)
        }
        else if(indexPath.row == 9){
            keychain.clear()
            performSegue(withIdentifier: STRING.goToLogin, sender: self)
        }
        
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4)
        {let productListViewModel = ProductListViewModel()
            productListViewModel.getProductDetails(product_category_id: String(productId)){data in
                DispatchQueue.main.async {
                    if (data.status == 200){
                        self.productList = data
                        self.performSegue(withIdentifier: STRING.goToTableProductList, sender: self)
                    }
                   // print("Successfully GOT details ")
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: STRING.goToCell, for: indexPath) as! SideMenuTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        cell.sideImageView.image =  optionIconsArray[indexPath.row]
        cell.sideLabel.text = optionsArray[indexPath.row]
        if(indexPath.row == 0)
        {
            cell.cartItemLabel.text  = String(cartCount)
        }
        else{
            cell.cartItemLabel.isHidden = true
        }
        cell.cartItemLabel.text  = keychain.get(STRING.totalCarts)
        return cell
    }
}

// MARK: - Navigation
extension SideMenuViewController{
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == STRING.goToTableProductList) {
            // pass data to next view
            if let nextViewController = segue.destination as? TableProductListViewController {
                nextViewController.productID = productId
                nextViewController.productList = productList//Or pass any values
            }
        }
        else if (segue.identifier == STRING.goToMyAccount) {
            // pass data to next view
            if let nextViewController = segue.destination as? MyAccountViewController {
                nextViewController.myAccountDetails =  myAccountDetails//Or pass any values
            }
        }
        else if (segue.identifier == STRING.goToMyCart) {
            // pass data to next view
            if let nextViewController = segue.destination as? MyCartViewController {
                nextViewController.myCartDetails =  myCartDetails//Or pass any values
            }
        }
        else if (segue.identifier == STRING.goToMyOrders) {
            // pass data to next view
            if let nextViewController = segue.destination as? MyOrdersViewController {
                nextViewController.orderListResponse =  orderListResponse//Or pass any values
            }
        }
    }
}


