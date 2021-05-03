//
//  MyOrdersViewController.swift
//  Neostore
//
//  Created by webwerks1 on 02/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var orderListResponse : OrderListResponse?
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
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK:- IBActions
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- TableView Extension
extension MyOrdersViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListResponse?.data?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderDetailViewModel = OrderDetailViewModel()
        orderDetailViewModel.getorderDetails(order_id: String(orderListResponse?.data?[indexPath.row].id ?? 2757)){data in
            DispatchQueue.main.async {
                if (data.status == 200){
                    self.orderDetail = data
                    self.performSegue(withIdentifier: STRING.goToOrderId, sender: self)
                }
               // print("Successfully GOT Order details ")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: STRING.myOrdersCell, for: indexPath) as! MyOrderTableViewCell
        cell.orderIdLabel.text = "\(STRING.orderID) \(String(orderListResponse?.data?[indexPath.row].id ?? 786))"
        cell.orderDateLabel.text = "\(STRING.orderDate) \(orderListResponse?.data?[indexPath.row].created ?? STRING.date)"
        cell.orderPrice.text = "\(STRING.moneySymbol) \(String(orderListResponse?.data?[indexPath.row].cost ?? 786)).00"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
}

//MARK:- Navigation
extension MyOrdersViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == STRING.goToOrderId) {
            // pass data to next view
            if let nextViewController = segue.destination as? OrderIdViewController {
                nextViewController.orderDetail = orderDetail
            }
        }
    }
}

