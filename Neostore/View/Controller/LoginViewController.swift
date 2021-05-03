//
//  ViewController.swift
//  Neostore
//
//  Created by webwerks1 on 15/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    // MARK:- IBoutlets
    @IBOutlet weak var neostoreLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupUI()
    {
        usernameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        passwordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.password_icon))
        loginButton.setCorner()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil,  action: nil)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func validateTextFileds()->Bool
    {
        if((usernameTextField.text == nil) || (usernameTextField.text?.isEmpty)!){
            usernameTextField.placeholder = STRING.usernamePlaceHolder
            return false
        }else if((passwordTextField.text == nil) || (passwordTextField.text?.isEmpty)!){
                 passwordTextField.placeholder = STRING.passwordPlaceHolder
            return false
        }
        else
        {
            return true
        }
    }
    
    //MARK:- IBActions
    @IBAction func didSelectLogin(_ sender: UIButton) {
        if(validateTextFileds()){
            let loginViewModel = LoginViewModel()
            loginViewModel.login(email: (usernameTextField.text)!, pass: (passwordTextField.text)!){(data,bool) in
                if(bool){
                    Alert.failPopUp(message: STRING.validCredentials, viweControler: self)
                }
                if (data?.status == 200){
                    DispatchQueue.main.async {
                        if (data?.status == 200){
                            let myAccountViewMode = MyAccountViewModel()
                            myAccountViewMode.getUserDetails{data in
                            }
                            Alert.alertPopUp(identifier: STRING.goToHome, message: (data?.user_msg!)!, actionEnum: .segue , viewController: self)
                        }
                    }
                }
            }
        }
        else{
            Alert.failPopUp(message:STRING.fillAllDetails, viweControler: self)
        }
    }
    
    @IBAction func didSelectForgotPassword(_ sender: UIButton) {
        performSegue(withIdentifier: STRING.goToForgot, sender: self)
    }
}

//MARK:- UITextFieldDelegate
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- Navigation
extension LoginViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.isNavigationBarHidden = true
    }
}

