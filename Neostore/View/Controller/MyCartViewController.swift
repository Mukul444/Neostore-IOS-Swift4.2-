//
//  MyCartViewController.swift
//  Neostore
//
//  Created by webwerks1 on 14/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import KeychainSwift

class MyCartViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var orderNowBtn: UIButton!
    
    //MARK:- Variables
    var myCartDetails : ListCartResponse?
    var deleteCartResponse : DeleteCartResponse?
    let keychain = KeychainSwift()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableViewSetup()
    {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupUI()
    {
        orderNowBtn.setCorner()
        totalAmountLabel.text = "\(STRING.moneySymbol) \(myCartDetails?.total ?? 000000).00"
    }
    
    //MARK:- IBActions
    @IBAction func didTapOrderNowBtn(_ sender: UIButton) {
        performSegue(withIdentifier: STRING.goToAddressList, sender: self)
    }
    
    @IBAction func didTapBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- TableView Extension
extension MyCartViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartDetails?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: STRING.goToMyCartCell, for: indexPath) as! MyCartTableViewCell
        cell.editCartDelegate = self
        cell.productNameLabel.text = myCartDetails?.data?[indexPath.row].product?.name
        cell.priceLabel.text = "\(STRING.moneySymbol) \(myCartDetails?.data?[indexPath.row].product?.subTotal ?? 000000).00"
        if let url = myCartDetails?.data?[indexPath.row].product?.productImages{
            let imageUrl =  URL(string : url)
            cell.productImage.kf.setImage(with: imageUrl)
        }
        else {
            print (STRING.didNotGetURL)
        }
        cell.quantityLabel.text = String(myCartDetails?.data?[indexPath.row].quantity ?? 1)
        cell.poductId = myCartDetails?.data?[indexPath.row].productId ?? 1
        cell.productTypeLabel.text = "(" + (myCartDetails?.data?[indexPath.row].product?.productCategory)! + ")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            let myCartViewModel = MyCartViewModel()
            myCartViewModel.deleteCart(product_id: String(self.myCartDetails?.data?[indexPath.row].productId ?? 1)){data in
                DispatchQueue.main.async {
                    if (data.status == 200)
                    {
                        self.deleteCartResponse = data
                        self.keychain.set("\(data.totalCarts!)", forKey: STRING.totalCarts)
                        myCartViewModel.listCart{data in
                            DispatchQueue.main.async {
                                if (data.status == 200){
                                    self.myCartDetails = data
                                }
                                tableView.reloadData()
                            }
                        }
                    }
                   // print("Successfully ADDED TO CART  ")
                }
            }
            completion(true)
        }
        deleteAction.image = #imageLiteral(resourceName: "recycle")
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK:- EditCartDelegate
extension MyCartViewController : EditCartDelegate {
    func relodTableData(myCartDetails: ListCartResponse) {
        self.myCartDetails = myCartDetails
        totalAmountLabel.text = "\(STRING.moneySymbol) \(myCartDetails.total ?? 0000000).00"
        tableView.reloadData()
    }
}
