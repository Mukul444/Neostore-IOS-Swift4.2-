//
//  OrderIdViewController.swift
//  Neostore
//
//  Created by webwerks1 on 02/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class OrderIdViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
     var orderDetail : OrderDetailResponse?
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
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
    
    //MARK:- IBActions
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)

    }
}

//MARK:- TableView Extension
extension OrderIdViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetail?.data?.orderDetails?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: STRING.goToOrderIdCell, for: indexPath) as! OrderIDTableViewCell
        cell.productNameLabel.text = orderDetail?.data?.orderDetails?[indexPath.row].prodName
        cell.qtyLabel.text = "\(STRING.QTY) \(orderDetail?.data?.orderDetails?[indexPath.row].quantity ?? 0)"
        cell.priceLabel.text = "\(STRING.moneySymbol) \(orderDetail?.data?.orderDetails?[indexPath.row].total ?? 786).00"
        cell.productTypeLabel.text = orderDetail?.data?.orderDetails?[indexPath.row].prodCatName
        if let url = orderDetail?.data?.orderDetails?[indexPath.row].prodImage{
            let imageUrl =  URL(string : url)
            cell.productImage.kf.setImage(with: imageUrl)
        }
        else {
            print (STRING.didNotGetURL)
        }
        totalAmountLabel.text = String(orderDetail?.data?.cost ?? 786)
        navigationBar.topItem?.title = "\(STRING.orderID) \(orderDetail?.data?.id ?? 786)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.5
    }
    
}
