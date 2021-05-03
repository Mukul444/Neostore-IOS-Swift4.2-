//
//  AddAddressViewController.swift
//  Neostore
//
//  Created by webwerks1 on 14/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import KeychainSwift

class AddAddressViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var saveAddressBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    //MARK:- Variables
    var address : String?
    var addressList : [String] = []
    var keychain = KeychainSwift()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if(UserDefaults.standard.stringArray(forKey: STRING.addressList) != nil){
            addressList = UserDefaults.standard.stringArray(forKey: STRING.addressList)!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupUI(){let recognizer = UITapGestureRecognizer(target: self, action: #selector(touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)
        saveAddressBtn.setCorner()
        addressTextView.delegate = self
        townTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self
        countryTextField.delegate = self
        
    }
    
    @objc func touch() {
        self.view.endEditing(true)
    }
    
    func validateTextFileds()->Bool
    {
        if((townTextField.text == nil) || (townTextField.text?.isEmpty)!){
            townTextField.placeholder = STRING.townPlaceHolder
            return false
        }
        else if((cityTextField.text == nil) || (cityTextField.text?.isEmpty)!){
            cityTextField.placeholder = STRING.cityPlaceHolder
            return false
        }
        else if((stateTextField.text == nil) || (stateTextField.text?.isEmpty)!){
            stateTextField.placeholder = STRING.statePlaceHolder
            return false
        }
        else if((zipCodeTextField.text == nil) || (zipCodeTextField.text?.isEmpty)!){
            zipCodeTextField.placeholder = STRING.zipPlaceHolder
            return false
        }
        else if((countryTextField.text == nil) || (countryTextField.text?.isEmpty)!){
            countryTextField.placeholder = STRING.countryPlaceHolder
            return false
        }
        else
        {
            return true
        }
    }
    
    //MARK:- IBActions
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSaveAddress(_ sender: Any)
    {
        if(validateTextFileds())
        {
            address = "\(String(describing: addressTextView.text!)), \(String(describing: townTextField.text!)), \(String(describing: cityTextField.text!))- \(String(describing: zipCodeTextField.text!)), \(String(describing: countryTextField.text!))"
            addressList.append(address ?? STRING.addressNotFound)
            let defaults = UserDefaults.standard
            defaults.set(addressList, forKey: STRING.addressList)
            navigationController?.popViewController(animated: true)
        }
        else{
            Alert.failPopUp(message: STRING.fillAllDetails, viweControler: self)
        }
    }
}

    //MARK:- UITextFieldDelgate
extension AddAddressViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- UITextViewdDelgate
extension AddAddressViewController:UITextViewDelegate{
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        //addressTextView.resignFirstResponder()
//        //return true
//    }
}

