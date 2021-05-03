//
//  ProductDetailsViewController.swift
//  Neostore
//
//  Created by webwerks1 on 14/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var naviagtionBar: UINavigationBar!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet  var productRating: [UIImageView]!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var buyNowBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var secView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    
    //MARK:- Variables
    var productDetail : ShowProductDetails?
    var category = ""
    var selectedRow = -1
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
    
    func setupUI()
    {
        buyNowBtn.setCorner()
        rateBtn.setCorner()
        collectionViewSetup()
        naviagtionBar.topItem?.title = productDetail?.data?.name ?? STRING.ProductName
        productNameLabel.text = productDetail?.data?.name ?? STRING.ProductName
        selectCategory(productCategoryId: productDetail?.data?.productCategoryId ?? 1)
        categoryLabel.text = "\(STRING.Category) - \(category)"
        producerLabel.text = productDetail?.data?.producer ?? STRING.NeoShop
        var count = productDetail?.data?.rating ?? 3
        while(count != 0)
        {
            productRating[count-1].image = UIImage(named: IMAGE.star_check)
            count -= 1
        }
        costLabel.text = "Rs. \(String(productDetail?.data?.cost ?? 20000))"
        if let url = productDetail?.data?.productImages?[0].image{
            let imageUrl =  URL(string : url)
            bigImageView.kf.setImage(with: imageUrl)
        }
        else {
            print (STRING.didNotGetURL)
        }
        descriptionTextView.text = productDetail?.data?.descriptionField ?? STRING.failToLoadData
    }
    
    func selectCategory(productCategoryId : Int ){
        if(productCategoryId == 1){
            category = STRING.Table
        }
        else if(productCategoryId == 2){
            category = STRING.Chair
        }
        else if(productCategoryId == 3){
            category = STRING.Sofa
        }
        else{
            category = STRING.Cupboard
        }
    }
    
    //MARK:- IBActions
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapBuyNowBtn(_ sender: Any)
    {
        performSegue(withIdentifier: STRING.goToBuyNow, sender: self)
    }
    
    @IBAction func didTapRateBtn(_ sender: Any)
    {
        performSegue(withIdentifier: STRING.goToRate, sender: self)
    }
    
    @IBAction func didTapShareButton(_ sender: UIButton)
    {
        let activityController = UIActivityViewController(activityItems: [bigImageView.image!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = shareButton
        activityController.popoverPresentationController?.sourceRect = shareButton.frame
        present(activityController, animated: true, completion: nil)
    }
}

//MARK:- Collection View Setup
extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionViewSetup()
    {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.backgroundColor = UIColor.clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail?.data?.productImages?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STRING.ProductImagesCell, for: indexPath) as! ProductDetailsCollectionViewCell
        if let url = productDetail?.data?.productImages?[indexPath.row].image{
            let imageUrl =  URL(string : url)
          cell.productImage.kf.setImage(with: imageUrl)
        }
        else {
            print (STRING.didNotGetURL)
        }
        if selectedRow == indexPath.row {
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 1
        }
        else {
            cell.layer.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = productDetail?.data?.productImages?[indexPath.row].image{
            let imageUrl =  URL(string : url)
            bigImageView.kf.setImage(with: imageUrl)
        }
        else {
            print (STRING.didNotGetURL)
        }
        if selectedRow == indexPath.row {
            selectedRow = -1
        } else {
            selectedRow = indexPath.row
        }
        collectionView.reloadData()
    }
}

//MARK:- Navigation
extension ProductDetailsViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == STRING.goToBuyNow) {
            // pass data to next view
            if let nextViewController = segue.destination as? BuyNowViewController {
                nextViewController.productNameData = productDetail?.data?.name ?? STRING.ProductName
                if let url = productDetail?.data?.productImages?[0].image{
                    let imageUrl =  URL(string : url)
                    bigImageView.kf.setImage(with: imageUrl)
                    nextViewController.productImageData = bigImageView.image
                }
                else {
                    print (STRING.didNotGetURL)
                }
                nextViewController.productId = productDetail?.data?.id ?? 1
            }
        }
        if (segue.identifier == STRING.goToRate) {
            // pass data to next view
            if let nextViewController = segue.destination as? RateViewController {
                nextViewController.productNameData = productDetail?.data?.name ?? STRING.ProductName
                if let url = productDetail?.data?.productImages?[0].image{
                    let imageUrl =  URL(string : url)
                    bigImageView.kf.setImage(with: imageUrl)
                    nextViewController.productImageData = bigImageView.image
                }
                else {
                    print (STRING.didNotGetURL)
                }
                 nextViewController.productId = productDetail?.data?.id ?? 1
            }
        }
    }
}
