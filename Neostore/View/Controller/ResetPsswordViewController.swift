//
//  ResetPsswordViewController.swift
//  Neostore
//
//  Created by webwerks1 on 08/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class ResetPsswordViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    //MARK:- ViewLife Cycle
    override func viewDidLoad() {
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
        resetButton.setCorner()
        oldPasswordTextField.delegate = self
        passwordTextField.delegate = self
        conformPasswordTextField.delegate = self
        oldPasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.password_icon))
        passwordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.password_icon))
        conformPasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.cpassword_icon))
    }
    
    func validateTextFileds()->Bool
    {
        if((oldPasswordTextField.text == nil) || (oldPasswordTextField.text?.isEmpty)!){
            oldPasswordTextField.placeholder = STRING.fillAllDetails
            return false
        }
        else if((passwordTextField.text == nil) || (passwordTextField.text?.isEmpty)!){
            passwordTextField.placeholder = STRING.fillAllDetails
            return false
        }
        else if((conformPasswordTextField.text == nil) || (conformPasswordTextField.text?.isEmpty)!){
            conformPasswordTextField.placeholder = STRING.fillAllDetails
            return false
        }
        else
        {
            return true
        }
    }
    
    //MARK:- IBActions
    @IBAction func didSelectResetPassword(_ sender: UIButton) {
        if(validateTextFileds()){
            let resetPasswordViewModel = ResetPasswordViewModel()
            resetPasswordViewModel.resetPassword(old_password:(oldPasswordTextField.text)!, pass:(passwordTextField.text)!, confirm_password:conformPasswordTextField.text!){data,bool in
                if(bool){
                    Alert.failPopUp(message: STRING.failedToChangePassword, viweControler: self)
                }
                DispatchQueue.main.async {
                    if (data?.status == 200){
                        Alert.alertPopUp(identifier: nil, message: STRING.succefullyChangedThePassword, actionEnum: .popover, viewController: self)
                      //  print("Successfully Changed password")
                    }
                }
            }
        }
        else{
            Alert.failPopUp(message: STRING.fillAllDetails, viweControler: self)
        }
    }
    
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

  //MARK:- UITextFieldDelgate
extension ResetPsswordViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



