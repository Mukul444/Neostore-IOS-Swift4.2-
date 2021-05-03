//
//  AddressListViewController.swift
//  Neostore
//
//  Created by webwerks1 on 14/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import KeychainSwift

class AddressListViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!

    //MARK:- Variables
    var orderResponse : OrderResponse?
    var addressList : [String] =  []
    var selectedAddress = ""
    var buttonSelected = -1
    let keychain = KeychainSwift()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        placeOrderBtn.setCorner()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let defaults = UserDefaults.standard
        addressList = defaults.stringArray(forKey: STRING.addressList) ?? [String]()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- IBActions
    @IBAction func didTapBackBtn(_ sender: Any) {
       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapPlaceOrder(_ sender: Any) {
        let orderViewModel = OrderViewModel()
        orderViewModel.placeOrder(address: selectedAddress){data,bool in
            if(bool){
                Alert.failPopUp(message: STRING.someThingWentWrong, viweControler: self)
            }
            else{
                DispatchQueue.main.async {
                    if (data?.status == 200){
                        self.orderResponse = data
                        self.keychain.set(String(0), forKey: STRING.totalCarts)
                        Alert.alertPopUp(identifier: STRING.goToHomeScreen, message: STRING.Orderplaced, actionEnum: .segue, viewController: self)
                    }
                    //print("Successfully Placed Order Product ")
                }
            }
        }
    }
    
    @IBAction func didTapAddBtn(_ sender: Any) {
        performSegue(withIdentifier: STRING.goToAddAddress, sender: self)
    }
}

    //MARK:- TableViewSetup
extension AddressListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: STRING.goToAddressListCell, for: indexPath) as! AddressListTableViewCell
        cell.addressTextView.text = addressList[indexPath.row]
        cell.nameLabel.text = "\(keychain.get(STRING.first_name)!) \(keychain.get(STRING.last_name)!)"
        cell.closeBtn.tag = indexPath.row
        cell.closeBtn.addTarget(self, action: #selector(removeRow), for: .touchUpInside)
        cell.checkBtn.tag = indexPath.row
        cell.checkBtn.addTarget(self, action: #selector(setSelectAddress), for: .touchUpInside)
        if(buttonSelected == indexPath.row ){
            cell.checkBtn.isSelected = true
        }
        else
        {
            cell.checkBtn.isSelected = false
        }
        
        return cell
    }
    
    @objc func setSelectAddress(sender : UIButton){
        
        selectedAddress = addressList[sender.tag]
        if(buttonSelected == sender.tag ){
            buttonSelected = -1
        }
        else
        {
            buttonSelected = sender.tag
        }
        tableView.reloadData()
    }
    
    @objc func removeRow(sender : UIButton)
    {
        addressList.remove(at: sender.tag)
        UserDefaults.standard.set(addressList, forKey: STRING.addressList)
        tableView.reloadData()
    }
}
//MARK:- Navigation

