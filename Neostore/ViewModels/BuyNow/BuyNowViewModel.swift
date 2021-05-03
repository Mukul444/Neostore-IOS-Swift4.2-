//
//  RateViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 18/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
class BuyNowViewModel {
    // MARK:- Variables
    var responseData : AddToCartResponse?
    
    //MARK:- Functions and Methods
    func addToCart(product_id:String,quantity : Int, completionHandler:@escaping (AddToCartResponse?,Bool)->Void)
    {
        let url = STRING.addToCartURL
        let header = true
        let para : [String: Any] = [STRING.product_id :"\(product_id)",
            STRING.quantity:quantity]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(AddToCartResponse.self, from: data2)
                    guard  let responseData = self.responseData else {return}
                    print(responseData)
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
