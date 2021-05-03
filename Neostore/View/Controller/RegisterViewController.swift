//
//  RegisterViewController.swift
//  Neostore
//
//  Created by webwerks1 on 17/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - VARIABLES
    var genderValue = ""
    
    // MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        firstNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        lastNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.email_icon))
        passwordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.password_icon))
        conformPasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.password_icon))
        phoneTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.cellphone_icon))
        registerButton.setCorner()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.conformPasswordTextField.delegate = self
        self.phoneTextField.delegate = self
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc func touch() {
        self.view.endEditing(true)
    }
    
    func validateTextFields() -> Bool
    {
        if ((firstNameTextField.text?.isEmpty)!){
            firstNameTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if ((lastNameTextField.text?.isEmpty)!){
            lastNameTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if ((emailTextField.text?.isEmpty)!){
            emailTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if ((passwordTextField.text?.isEmpty)!){
            passwordTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if ((conformPasswordTextField.text?.isEmpty)!){
            conformPasswordTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if(passwordTextField.text != conformPasswordTextField.text){
            conformPasswordTextField.text = ""
            conformPasswordTextField.placeholder = STRING.paswordDoesNotMatch
            conformPasswordTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if ((phoneTextField.text?.isEmpty)!){
            phoneTextField.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            return false
        }
        else if(checkButton.isSelected != true){
            return false
        }
        else if(genderValue == "")
        {
            return false
        }
        else {
            firstNameTextField.backgroundColor = .clear
            lastNameTextField.backgroundColor = .clear
            emailTextField.backgroundColor = .clear
            conformPasswordTextField.backgroundColor = .clear
            passwordTextField.backgroundColor = .clear
            phoneTextField.backgroundColor = .clear
            return true
        }
    }
    
    // MARK: - IBACTIONS
    @IBAction func radioBtnChecked(_ sender: UIButton) {
        if sender.tag == 1 // on interface builder in veiw mode there is tag option ehic is selected as 1
        {
            maleButton.isSelected = true
            femaleButton.isSelected = false
            genderValue = STRING.M
            // print("male slected")
        }
        else if sender.tag == 2
        {
            
            femaleButton.isSelected = true
            maleButton.isSelected = false
            genderValue = STRING.F
            // print("female selected")
        }
    }
    
    @IBAction func didSelectCheckbtn(_ sender: UIButton) {
        if (checkButton.isSelected == true){
            checkButton.isSelected = false
        }
        else{
            checkButton.isSelected = true
        }
    }
    
    @IBAction func didSelectRegister(_ sender: UIButton) {
        let result : Bool = validateTextFields()
        if (result){
            let userDataToSend  = UserPost(firstName: firstNameTextField.text!,
                                           lastName: lastNameTextField.text!,
                                           email: emailTextField.text!,
                                           password: passwordTextField.text!,
                                           confirmPassword: conformPasswordTextField.text!,
                                           gender: genderValue,
                                           phoneNo: Int(phoneTextField.text!)!)
            let registerModelView = RegisterModelView()
            registerModelView.register(user : userDataToSend){(data,bool) in
                if(bool){
                    Alert.failPopUp(message: STRING.emailAlreadyUsed,
                                    viweControler: self)
                }
                else{
                    DispatchQueue.main.async {
                        if (data?.status == 200){
                            Alert.alertPopUp(identifier: nil,
                                             message: STRING.successfullyRegisterd,
                                             actionEnum: .popover,
                                             viewController: self)
                        }
                    }
                }
            }
        }
        else
        {
            Alert.failPopUp(message: STRING.checkBoxes, viweControler: self)
        }
    }
}

// MARK: UITextFieldDelegate
extension RegisterViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneTextField.resignFirstResponder()
        self.view.endEditing(true)
        firstNameTextField.resignFirstResponder()
    }
}

