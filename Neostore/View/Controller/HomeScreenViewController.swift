//
//  HomeScreenViewController.swift
//  Neostore
//
//  Created by webwerks1 on 24/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import SideMenu

class HomeScreenViewController: UIViewController {
    
    // MARK:- IBOulets
    @IBOutlet weak var parentScrollView: UIView!
    @IBOutlet weak var parentCollectionView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- Variables
    var  menu :  UISideMenuNavigationController?
    var imageArray : [UIImage] = HomeViewModel.imageArray
    let layout  = UICollectionViewFlowLayout()
    var thumblines : [UIImage] = HomeViewModel.thumblines
    var productId : Int = 1
    var productList : ProductList?
    var myAccountDetails : GetUserData?
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
         sideMenuSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        setupScrollView()
        collectioViewCellSetup()
    }
    
    // MARK:- IBACTIONS
    @IBAction func didTapMenu(){
        present(menu!,animated: true)
    }
    
}

// MARK:- ScrollView_Setup
extension HomeScreenViewController : UIScrollViewDelegate
{
    func setupScrollView(){
        scrollView.delegate = self
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = imageArray[i]
            let xPos = CGFloat(i) * self.view.bounds.width
            imageView.frame = CGRect(x: xPos,
                                     y: 0,
                                     width: view.frame.width,
                                     height: scrollView.frame.height)
            scrollView.contentSize.width = view.frame.width * CGFloat(i + 1)
            scrollView.isPagingEnabled = true
            scrollView.isScrollEnabled = true
            scrollView.addSubview(imageView)
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.width))
        pageControl.currentPage = Int(page)
    }
}

//MARK:- Collection_View_Setup
extension HomeScreenViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionViewSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.clear
    }
    
    func collectioViewCellSetup(){
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (parentCollectionView.frame.size.width-36)/2, height: (parentCollectionView.frame.size.height/2)-20)
        layout.minimumLineSpacing = 11.5
        layout.minimumInteritemSpacing = 11.5
        collectionView!.collectionViewLayout = layout
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 0){
            productId = 1
        }
        else if (indexPath.row == 1){
            productId = 3
        }
        else if (indexPath.row == 2){
            productId = 2
        }
        else {
            productId = 4
        }
        
        let productListViewModel = ProductListViewModel()
        productListViewModel.getProductDetails(product_category_id: String(productId)){data in
            DispatchQueue.main.async {
                if (data.status == 200){
                    self.productList = data
                    self.performSegue(withIdentifier: STRING.goToTableProductList, sender: self)
                }
                //print("Successfully GOT details ")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.imageName(imageFromArray: thumblines[indexPath.row])
        return cell
    }
    
    
}
//MARK:- SIDE_MENU_SETUP
extension HomeScreenViewController
{
    func sideMenuSetup()  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: STRING.sideMenuIdentifier)
        menu = UISideMenuNavigationController(rootViewController: vc!)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true,animated : false)
        SideMenuManager.default.menuLeftNavigationController = menu
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
    }
}
//MARK:- Navigation setup
extension HomeScreenViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == STRING.goToTableProductList) {
            // pass data to next view
            if let nextViewController = segue.destination as? TableProductListViewController {
                nextViewController.productID = productId
                nextViewController.productList = productList
            }
        }
    }
}


