//
//  LoginViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 06/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

import UIKit
import KeychainSwift

class LoginViewModel {
    // MARK:- Variables
    var responseData : UserData?
    var keychain = KeychainSwift()
    
    //MARK:- Functions and Methods
    func login(email : String,pass  : String, completionHandler:@escaping (UserData?,Bool)->Void)
    {
        let url = STRING.loginPostUrl
        let para : [String : Any] = [STRING.email:"\(email)",STRING.password:"\(pass)"]
        let header = false
        let loginPostApi = HttpMethods()
        loginPostApi.setupPostMethod(urlFromModel:url , parameter: para, method: STRING.httpPostMethod, header: header){ (result) in
            switch result {
            case .Success(let data):
                //print("the value is passed\(data)")
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(UserData.self, from: data2)
                    let data2Data = self.responseData!.data
                    if (self.keychain.set((data2Data?.access_token)!, forKey: STRING.access_token, withAccess: KeychainSwiftAccessOptions.accessibleAlways)){
                       // print("values is set to keychain")
                    }
                    else{
                        //print("value failed to set")
                    }
                    self.keychain.set((data2Data?.email)!, forKey: STRING.email)
                    self.keychain.set((data2Data?.first_name)!, forKey: STRING.first_name)
                    self.keychain.set((data2Data?.last_name)!, forKey: STRING.last_name)
                    
                    //print(self.responseData)
                    guard  let responseData = self.responseData else {return}
                    completionHandler(responseData,false)
                }
                catch {
                    print(STRING.failToLoadData)
                    completionHandler(nil,true)
                }
            case .Error(let message):
                print(message)
            }
        }
    }
}
