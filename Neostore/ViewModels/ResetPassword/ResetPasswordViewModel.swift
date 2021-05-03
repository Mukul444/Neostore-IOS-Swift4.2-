//
//  ResetPasswordViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 08/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit

class ResetPasswordViewModel {
    // MARK:- Variables
    var responseData : UserData?
    
    //MARK:- Functions and Methods
    func resetPassword(old_password:String, pass:String, confirm_password: String, completionHandler:@escaping (UserData?,Bool)->Void)
    {
        let url = STRING.resetPasswodUrl
        let para: [String : Any] =
            [
            STRING.old_password :"\(old_password)",
            STRING.password :"\(pass)",
            STRING.confirm_password:"\(confirm_password)"]
        let header = true
        let api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(UserData.self, from: data2)
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
