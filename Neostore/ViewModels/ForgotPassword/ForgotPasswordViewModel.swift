//
//  ForgotPasswordViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 07/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

class ForgotPasswordViewModel {
    // MARK:- Variables
    var responseData : ForgotPasswordResponse?
    
    //MARK:- Functions and Methods
    func forgotPassword(email : String, completionHandler:@escaping (ForgotPasswordResponse?,Bool)->Void)
    {
        let url = STRING.forgotURL
        let para : [String : Any] = [STRING.email:"\(email)"]
        let header = false
        let loginPostApi = HttpMethods()
        loginPostApi.setupPostMethod(urlFromModel:url , parameter: para, method: STRING.httpPostMethod, header: header){ (result) in
            switch result {
            case .Success(let data):
                //print("the value is passed\(data)")
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(ForgotPasswordResponse.self, from: data2)
                    print(self.responseData!)
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
