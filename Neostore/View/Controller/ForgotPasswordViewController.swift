//
//  ForgotPasswordViewController.swift
//  Neostore
//
//  Created by webwerks1 on 17/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    //MARK: - IBoutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendPasswordButton: UIButton!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.email_icon))
        sendPasswordButton.setCorner()
        navigationItem.title = STRING.Forgot
        emailTextField.delegate = self
    }
    func validateTextFileds()->Bool
    {
        if((emailTextField.text == nil) || (emailTextField.text?.isEmpty)!){
            emailTextField.placeholder = STRING.emailPlaceholder
            return false
        }
        else
        {
            return true
        }
    }
    
    //MARK:- IBAction
    @IBAction func didSelectForgotPassword(_ sender: UIButton) {
        if(validateTextFileds()){
            let forgotPasswordViewModel = ForgotPasswordViewModel()
            forgotPasswordViewModel.forgotPassword(email: (emailTextField.text)!){data,bool in
                if(bool){
                    Alert.failPopUp(message: STRING.validCredentials, viweControler: self)
                }
                else{
                    DispatchQueue.main.async {
                        if (data?.status == 200){
                            let messgae = ("\(STRING.passwordSentToMail) \((self.emailTextField.text)!)")
                            Alert.alertPopUp(identifier: nil, message: messgae , actionEnum: .popover, viewController: self)
                        }
                    }
                }
            }
        }
    }
}
    //MARK:- UITextFiledDelegate
extension ForgotPasswordViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

