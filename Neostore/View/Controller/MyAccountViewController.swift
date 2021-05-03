//
//  MyAccountViewController.swift
//  Neostore
//
//  Created by webwerks1 on 08/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var firstNametxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneNoTxtField: UITextField!
    @IBOutlet weak var dobTxtField: UITextField!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    //MARK:-Variables
    var myAccountDetails : GetUserData?
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //let gett = Get()
        //gett.get()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           setupUI()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func setupUI(){
        profilePicImageView.setCorner(radius: 66.5)
        firstNametxtField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        lastNameTxtField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.username_icon))
        emailTxtField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.email_icon))
        phoneNoTxtField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.password_icon))
        dobTxtField.setIcon(_ImageLiteralType(imageLiteralResourceName: IMAGE.dob_icon))
        editProfileBtn.setCorner()
        if let url  = myAccountDetails?.data?.userData?.profile_pic{
            profilePicImageView.image = UIImage().getImageFromUrl(picUrl: url)
        }
        else{
            profilePicImageView.image = UIImage(named: IMAGE.user_male)
        }
        self.firstNametxtField.text = myAccountDetails?.data?.userData?.first_name
        self.lastNameTxtField.text = myAccountDetails?.data?.userData?.last_name
        self.emailTxtField.text = myAccountDetails?.data?.userData?.email
        self.phoneNoTxtField.text = myAccountDetails?.data?.userData?.phone_no
        self.dobTxtField.text = myAccountDetails?.data?.userData?.dob
    }
    
    //MARK:- IBActions
    @IBAction func didSelectResetPasswordBtn(_ sender: UIButton) {
        performSegue(withIdentifier: STRING.goToResetPassword, sender: self)
    }
    @IBAction func didSelectEditProfile(_ sender: UIButton) {
        performSegue(withIdentifier: STRING.goToEditDetails, sender: self)
    }
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)

    }
}
//MARK NAvigation
extension MyAccountViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == STRING.goToEditDetails)
        {
            // pass data to next view
            if let nextViewController = segue.destination as? EditProfileViewController
            {
                nextViewController.myAccountDetails = myAccountDetails
                nextViewController.editProfileDelegate = self
            }
        }
    }
}
extension MyAccountViewController : EditProfileDelegate
{
    func updateUserDetails(updatedUserData: GetUserData) {
        myAccountDetails = updatedUserData
    }
}
