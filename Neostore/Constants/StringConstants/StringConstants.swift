//
//  StringConstants.swift
//  Neostore
//
//  Created by webwerks1 on 07/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
class STRING{
    //MARK:- HTTPGeneralMethods
    public static let unknownError = "Unknown Error"
    public static let statusCode = "Status Code"
    public static let Successfull = "Successfull"
    public static let UnSuccessfull = "UnSuccessfull"
    public static let httpPostMethod = "POST"
    public static let httpGetMethod = "GET"
    public static let failToLoadData = "failed to load data"
    
    //MARK:- LoginViewController
    public static let usernamePlaceHolder = "Please Fill Username"
    public static let passwordPlaceHolder = "Please Fill Password"
    public static let fillAllDetails = "Login"
    public static let validCredentials = "Please Fill Valid Credentials"
    public static let login = "Login"
    
    //MARK:- LoginViewModel
    public static let loginPostUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/login"
    public static let email =  "email"
    public static let password =  "password"
    public static let first_name =  "first_name"
    public static let last_name =  "last_name"
    public static let confirm_password =  "confirm_password"
    public static let gender =  "gender"
    public static let phoneNo = "phone_no"
    public static let access_token = "access_token"
    public static let profile_pic = "profile_pic"
    public static let totalCarts = "totalCarts"
    public static let product_id = "product_id"
    public static let quantity = "quantity"
    public static let moneySymbol = "₹"
    public static let product_category_id = "product_category_id"
    public static let dob = "dob"
    
    //MARK:- ForgotPasswordViewController
    public static let Forgot = "Forgot"
    public static let emailPlaceholder = "Please Fill Email"
    public static let passwordSentToMail = "New Password Sent To Mail"
    public static let forgotURL = "http://staging.php-dev.in:8844/trainingapp/api/users/forgot"
    
    //MARK:- ForgotPasswordViewController
    public static let paswordDoesNotMatch = "PASSWORD DOES NOT MATCH"
    public static let M = "M"
    public static let F = "F"
    public static let emailAlreadyUsed = "Email is already used"
    public static let successfullyRegisterd = "Successfully Registerd"
    public static let checkBoxes = "Please Check T&C And Gender"
    public static let registerURL = "http://staging.php-dev.in:8844/trainingapp/api/users/register"
    
    //MARK:- HomeScreenViewController
    public static let sideMenuIdentifier = "sideMenu"
    
    //MARK:- SideMenuViewController
    public static let MyCart = "My Cart"
    public static let Table = "Table"
    public static let Sofa = "Sofa"
    public static let Chair = "Chair"
    public static let Cupboard = "Cupboard"
    public static let MyAccount = "My Account"
    public static let StoreLocator = "Store Locator"
    public static let MyOrders = "My Orders"
    public static let Address = "Address"
    public static let Logout = "Logout"
    
    //MARK:- MyCartViewController
    public static let didNotGetURL = "did not get url"
    public static let listCartURL =   "http://staging.php-dev.in:8844/trainingapp/api/cart"
    public static let editCartURL =   "http://staging.php-dev.in:8844/trainingapp/api/editCart"
    public static let deleteCartURL = "http://staging.php-dev.in:8844/trainingapp/api/deleteCart"
    
    //MARK:- AddresListViewController
    public static let addressList = "addressList"
    public static let someThingWentWrong = "Something went Wrong"
    public static let Orderplaced = "Order placed"
     public static let placeOrderURL = "http://staging.php-dev.in:8844/trainingapp/api/order"
     public static let address = "address"

    
    //MARK:- AddresListViewController
    public static let cityPlaceHolder = "Please Fill City"
    public static let townPlaceHolder = "Please Fill Town"
    public static let statePlaceHolder = "Please Fill State"
    public static let zipPlaceHolder = "Please Fill Zip Code"
    public static let countryPlaceHolder = "Please Fill Country"
    public static let addressNotFound = "Address Not Found"
    
    //MARK:- TableProductlistViewController
    public static let ProductListViewCell = "ProductListViewCell"
    public static let getProductListURL = "http://staging.php-dev.in:8844/trainingapp/api/products/getList"
    public static let urlIsNotPrepared = "url is not prepared"
    
    //MARK:- ProductDetailsViewController
    public static let getProductDetailURL = "http://staging.php-dev.in:8844/trainingapp/api/products/getDetail"
    public static let ProductName = "ProductName"
    public static let Category = "Category"
    public static let NeoShop = "NeoShop"
    
    //MARK:- BuyNowViewController
    public static let failedToAddCart = "Failed to add to cart"
    public static let addedToCart = "Added to cart"
    public static let addToCartURL = "http://staging.php-dev.in:8844/trainingapp/api/addToCart"
    
    //MARK:- RateViewController
    public static let failedToRate =  "failed to rate"
    public static let ratedSuccessfully = "Rated Successfully"
    public static let rateURL = "http://staging.php-dev.in:8844/trainingapp/api/products/setRating"
    public static let rating = "rating"
    
    //MARK:- EditProfileViewController
    public static let accessIsGrantedByUser = "Access is granted by user"
    public static let notDetermined = "It is not determined until now"
    public static let noAccess = "User do not have access to photo album."
    public static let deniedAccess = "User has denied the permission."
    public static let imageError = "could no convert image to string"
    public static let failToEditDetails = "Failed to Edit details"
    public static let updatedToUserDetails = "Updated User Details"
    
    //MARK:- ResetPasswordViewModel
    public static let resetPasswodUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/change"
    public static let failedToChangePassword = "failed to change the pasword"
    public static let succefullyChangedThePassword =  "successfully changed the password"
    public static let old_password = "old_password"
    
    //MARK:- MyOrdersViewController
    public static let orderID = "Order ID :"
    public static let orderDate = "Ordered Date :"
    public static let date = "10-10-2000"
    public static let QTY = "QTY :"
    public static let orderListURL = "http://staging.php-dev.in:8844/trainingapp/api/orderList"
    public static let order_id = "order_id"
     public static let orderDetailsURL = "http://staging.php-dev.in:8844/trainingapp/api/orderDetail"
    
    public static let getUserDataURL = "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData"
    public static let updateUserDataURL = "http://staging.php-dev.in:8844/trainingapp/api/users/update"
    //MARK:- StoreLocator
    public static let luna = "Luna"
    public static let carlo = "Carlo"
    public static let fabia = "Fabia"
    public static let leLo = "LeLo"
    public static let neoLo = "NeoLo"
    public static let hP = "HP"
    public static let futureFurnitureCentre = "Future Furniture Centre"
    public static let iKEA = "IKEA"
    public static let lunaAddress = "6335 Edgewood Road Reisterstown, MD 21136"
    public static let carloAddress = "9337 Pine Oak Drive South Plainfield, NJ 07080"
    public static let fabiaAddress = "3798 Pennsylvania Avenue Drive Brandon, FL 33510"
    public static let leLoAddress = "9311 Garfield Avenue Hamburg, NY 14075"
    public static let neoLoAddress = "7346 Hanover Court Arlington, MA 02474"
    public static let hPAddress = "6394 Rodeo Drive Avenue, LA 3215"
    public static let futureFurnitureCentreAddress =  "5839 Hollywood Blwd, LA 4593"
    public static let iKEAAddress = "1532 Calibasus Valley Druve, LA 0213 "
    public static let storeLocator = "store locator"
    
    //MARk:- ViewController Segue Identifiers
    public static let goToHome =  "goToHome"
    public static let goToForgot =  "goToForgot"
    public static let goToTableProductList =  "goToTableProductList"
    public static let goToMyAccount =  "goToMyAccount"
    public static let goToStoreLocator =  "goToStoreLocator"
    public static let goToMyOrders =  "goToMyOrders"
    public static let goToLogin =  "goToLogin"
    public static let goToAddressList =  "goToAddressList"
    public static let goToMyCart =  "goToMyCart"
    public static let goToHomeScreen =  "goToHomeScreen"
    public static let goToAddAddress =  "goToAddAddress"
    public static let goToProductDetails =  "goToProductDetails"
    public static let goToBuyNow =  "goToBuyNow"
    public static let goToResetPassword =  "goToResetPassword"
    public static let goToEditDetails =  "goToEditDetails"
    public static let goToOrderId =  "goToOrderId"
    public static let goToHomeScreenCart =  "goToHomeScreenCart"
    public static let goToRate =  "goToRate"
    public static let goToAddressListMenu =  "goToAddressListMenu"
    
    //MARk:- Cell Segue Identifiers
    public static let goToCell =  "cell"
    public static let goToMyCartCell =  "goToMyCart"
    public static let goToAddressListCell = "goToAddressList"
    public static let productListViewCell = "productListViewCell"
    public static let ProductImagesCell = "ProductImages"
    public static let myOrdersCell = "goToMyOrders"
    public static let goToOrderIdCell = "goToOrderId"
    public static let customCollectionViewCellIdentifier = "customCollectionViewCell"
    
    
    
    
    
    
}
