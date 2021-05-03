//
//  TableProductListViewController.swift
//  Neostore
//
//  Created by webwerks1 on 31/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import Kingfisher

class TableProductListViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    //MARK:- Variables
    var productID : Int  = 3
    var productList  : ProductList?
    var productDetail : ShowProductDetails?
    let searchBar = UISearchBar()
    var filteredArray : [ProductDetails] = []
    
    
    // MARK:- ViewLifeCycle
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
        searchBar.autocapitalizationType = .none
        filteredArray = productList?.data ?? []
        searchBar.sizeToFit()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: STRING.ProductListViewCell, bundle: nil), forCellReuseIdentifier: STRING.productListViewCell)
        tableView.tableFooterView = UIView()
    }
    
    func setupUI()
    {
        if productID == 1{
            navigationBar.topItem?.title = STRING.Table
        }
        else if (productID == 3 ){
            navigationBar.topItem?.title = STRING.Sofa
        }
        else if (productID == 2 ){
            navigationBar.topItem?.title = STRING.Chair
        }
        else {
            navigationBar.topItem?.title = STRING.Cupboard
        }
    }
    
    @objc func handleShowSearchBar(){
        navigationBar.topItem?.title = nil
        showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func showSearchBarButton(shouldShow : Bool)
    {
        if(shouldShow){
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                        target: self,
                                                                        action: #selector(handleShowSearchBar))
        }
        else{
            navigationBar.topItem?.rightBarButtonItem = nil
        }
    }
    
    func showSearchBar(shouldShow : Bool)
    {
        showSearchBarButton(shouldShow : !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationBar.topItem?.titleView = shouldShow ? searchBar : nil
    }
    
    //MARK:- IBActions
    @IBAction func didTapBack(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSearchBar(_ sender: Any)
    {
        handleShowSearchBar()
    }
}

//MARK:- TableView Setup
extension TableProductListViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsViewModel = ProductDetailsViewModel()
        productDetailsViewModel.getProductDetails(product_id: String(productList?.data?[indexPath.row].id ?? 1)){data in
            DispatchQueue.main.async {
                if (data.status == 200){
                    self.productDetail = data
                    self.performSegue(withIdentifier: STRING.goToProductDetails, sender: self)
                }
                // print("Successfully GOT Product details ")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: STRING.productListViewCell, for: indexPath) as! ProductListViewCell
        if let url = filteredArray[indexPath.row].productImages{
            let imageUrl =  URL(string : url)
            cell.productImage.kf.setImage(with: imageUrl)
        }
        else {
            print (STRING.didNotGetURL)
        }
        cell.productName.text = filteredArray[indexPath.row].name ?? STRING.Table
        cell.productManufacturer.text = filteredArray[indexPath.row].producer ?? STRING.unknownError
        cell.productPrice.text = "Rs. \(String((filteredArray[indexPath.row].cost) ?? 20000))"
        var count = filteredArray[indexPath.row].rating ?? 2
        while( count != 0)
        {
            cell.productRating?[(count-1)].image = UIImage(named: IMAGE.star_check)
            count -= 1
        }
        return cell
    }
}

//MARK:- Navigation
extension TableProductListViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == STRING.goToProductDetails) {
            // pass data to next view
            if let nextViewController = segue.destination as? ProductDetailsViewController {
                nextViewController.productDetail = productDetail
            }
        }
    }
}

//MARK:- SearchBar
extension TableProductListViewController : UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setupUI()
        showSearchBar(shouldShow: false)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == ""){
            filteredArray = productList?.data ?? []
        } else {
            filteredArray = (productList?.data?.filter({($0.name?.lowercased().contains(searchText))!})) ?? []
        }
        self.tableView.reloadData()
    }
}
