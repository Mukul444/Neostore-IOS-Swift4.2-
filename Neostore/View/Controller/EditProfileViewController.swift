//
//  EditProfileViewController.swift
//  Neostore
//
//  Created by webwerks1 on 08/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import Photos
protocol EditProfileDelegate{
    func updateUserDetails(updatedUserData : GetUserData)
}

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:- IBOutlets
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNoTextFiled: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK:- Vairables
    var myAccountDetails : GetUserData?
    var editProfileDelegate : EditProfileDelegate?
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission() 
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
        submitButton.setCorner()
        profilePicImageView.setCorner(radius: 66.5)
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNoTextFiled.delegate = self
        dobTextField.delegate = self
        firstNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        lastNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.email_icon))
        phoneNoTextFiled.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.cellphone_icon))
        dobTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.dob_icon))
        let imageTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageTap.numberOfTouchesRequired = 1
        imageTap.numberOfTapsRequired = 1
        profilePicImageView.addGestureRecognizer(imageTap)
        profilePicImageView.isUserInteractionEnabled = true
        if let url  = myAccountDetails?.data?.userData?.profile_pic{
            profilePicImageView.image = UIImage().getImageFromUrl(picUrl: url)
        }
        else{
            profilePicImageView.image = UIImage(named: IMAGE.user_male)
        }
        self.firstNameTextField.text = myAccountDetails?.data?.userData?.first_name
        self.lastNameTextField.text = myAccountDetails?.data?.userData?.last_name
        self.emailTextField.text = myAccountDetails?.data?.userData?.email
        self.phoneNoTextFiled.text = myAccountDetails?.data?.userData?.phone_no
        self.dobTextField.text = myAccountDetails?.data?.userData?.dob
    }
    
    func validateTextFileds()->Bool
    {
        if((firstNameTextField.text == nil) || (firstNameTextField.text?.isEmpty)!){
            firstNameTextField.placeholder = STRING.usernamePlaceHolder
            return false
        }
        else if((lastNameTextField.text == nil) || (lastNameTextField.text?.isEmpty)!){
            lastNameTextField.placeholder = STRING.usernamePlaceHolder
            return false
        }
        else if((emailTextField.text == nil) || (emailTextField.text?.isEmpty)!){
            emailTextField.placeholder = STRING.email
            return false
        }
        else if((phoneNoTextFiled.text == nil) || (phoneNoTextFiled.text?.isEmpty)!){
            phoneNoTextFiled.placeholder = STRING.phoneNo
            return false
        }
        else if((dobTextField.text == nil) || (dobTextField.text?.isEmpty)!){
            dobTextField.placeholder = STRING.fillAllDetails
            return false
        }
        else
        {
            return true
        }
    }
    
    @objc func imageTapped() {
        //print("Imagetapped")
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: false, completion: nil)
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print(STRING.accessIsGrantedByUser)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("\(STRING.statusCode) \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print(STRING.Successfull)
                }
            })
            print(STRING.notDetermined)
        case .restricted:
            // same
            print(STRING.noAccess)
        case .denied:
            // same same
            print(STRING.deniedAccess)
        }
    }
    
    @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- IBActions
    @IBAction func didSelectSubmit(_ sender: UIButton) {
        if(validateTextFileds()){
            let editDetailsViewModel = EditDetialsViewModel()
            guard let imageData = profilePicImageView.image?.pngData()?.base64EncodedString() else{
                print(STRING.imageError)
                return
            }
            let fullBase64String = "data:image/png;base64,\(imageData))"
            editDetailsViewModel.editUserDetails(firstName:firstNameTextField.text!,
                                                 lastName:lastNameTextField.text!,
                                                 email: emailTextField.text!,
                                                 dob: dobTextField.text!,
                                                 phone: phoneNoTextFiled.text!,
                                                 profilePic: fullBase64String){(data,bool) in
                if(bool)
                {
                    Alert.failPopUp(message: STRING.failToEditDetails, viweControler: self)
                }
                else{
                    DispatchQueue.main.async {
                        if (data?.status == 200){
                            Alert.alertPopUp(identifier: nil, message:STRING.updatedToUserDetails, actionEnum: .doNothing, viewController: self)
                            //print("Successfully Updated details ")
                        }
                    }
                }
            }
        }
        else
        {
            Alert.failPopUp(message: STRING.fillAllDetails , viweControler: self)
        }
    }
    
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        let myAccountViewModel = MyAccountViewModel()
        myAccountViewModel.getUserDetails{data in
            DispatchQueue.main.async {
                if (data.status == 200){
                    self.myAccountDetails = data
                    if let updateddata = self.myAccountDetails{
                        self.editProfileDelegate?.updateUserDetails(updatedUserData: updateddata)
                        self.navigationController?.popViewController(animated: true)

                    }
                }
            }
        }
    }
}

  //MARK:- UITextFieldDelgate
extension EditProfileViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



