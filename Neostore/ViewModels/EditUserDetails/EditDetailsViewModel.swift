//
//  EditDetailsViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 10/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import KeychainSwift

class EditDetialsViewModel {
    // MARK:- Variables
    var responseData : UserData?
    var keychain = KeychainSwift()
    
    //MARK:- Functions and Methods
    func editUserDetails(firstName:String, lastName:String, email:String, dob:String, phone: String, profilePic:String, completionHandler:@escaping (UserData?,Bool)->Void)
    {
        let url = STRING.updateUserDataURL
        let para: [String : Any] = [
            STRING.first_name:"\(firstName)",
            STRING.last_name:"\(lastName)",
            STRING.email:"\(email)",
            STRING.dob:"\(dob)",
            STRING.profile_pic:"\(profilePic)",
            STRING.phoneNo:"\(phone)"
        ]
        let header = true
        let api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(UserData.self, from: data2)
                    let data2Data = self.responseData!.data
                    if (self.keychain.set((data2Data?.access_token)!, forKey: STRING.access_token, withAccess: KeychainSwiftAccessOptions.accessibleAlways))
                    {
                        print("\(String(describing: self.keychain.get( STRING.access_token)))")
                    }
                    else{
                        print(STRING.failToEditDetails)
                    }
                    guard  let responseData = self.responseData else {return}
                    completionHandler(responseData,false)
                }
                catch {
                    completionHandler(nil,true)
                    print(STRING.failToLoadData)
                }
            case .Error(let message):
                print(message)
            }
        }
    }
}
