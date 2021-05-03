//
//  MyAccountViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 12/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import KeychainSwift

class MyAccountViewModel {
    // MARK:- Variables
    var responseData : GetUserData?
    let keychain = KeychainSwift()
    
    //MARK:- Functions and Methods
    func getUserDetails(completionHandler:@escaping (GetUserData)->Void)
    {
        let url = STRING.getUserDataURL
        let header = true
        let para : [String: Any] = [:]
        let api = HttpMethods()
        api.parameterBool = false
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpGetMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(GetUserData.self, from: data2)
                    guard  let responseData = self.responseData else {return}
                    let data2Data = self.responseData?.data
                    self.keychain.set(String(data2Data?.totalCarts ?? 0), forKey: STRING.totalCarts)
                    self.keychain.set((data2Data?.userData?.profile_pic ?? ""), forKey: STRING.profile_pic)
                    completionHandler(responseData)
                }
                catch {
                    print(STRING.failToLoadData)
                }
            case .Error(let message):
                print(message)
            }
        }
    }
}
