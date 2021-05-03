//
//  LoginViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 06/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

import UIKit

class RegisterModelView {
    // MARK:- Variables
    var responseData : UserData?
    
    //MARK:- Functions and Methods
    func register(user : UserPost, completionHandler:@escaping (UserData?,Bool)->Void)
    {
        let url = STRING.registerURL
        let para : [String : Any] = [
            STRING.first_name:user.firstName!,
           STRING.last_name:user.lastName!,
            STRING.email:user.email!,
            STRING.password: user.password!,
            STRING.confirm_password:user.confirmPassword!,
            STRING.gender:user.gender!,
            STRING.phoneNo:user.phoneNo!]
        let header = false
        let postApi = HttpMethods()
        postApi.setupPostMethod(urlFromModel:url , parameter: para, method: STRING.httpPostMethod, header: header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(UserData.self, from: data2)
                    //print(self.responseData)
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
