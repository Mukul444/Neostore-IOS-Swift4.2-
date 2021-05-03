//
//  MyCartViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 19/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
class MyCartViewModel {
    // MARK:- Variables
    var listCartresponseData : ListCartResponse?
    var editCartResponseData : AddToCartResponse?
    var deleteCartResponse : DeleteCartResponse?
    static let numArray = ["1","2","3","4","5","6","7","8"]
    
    //MARK:- Functions and Methods
    func listCart(completionHandler:@escaping (ListCartResponse)->Void)
    {
        let url = STRING.listCartURL
        let header = true
        let para : [String: Any] = [:]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpGetMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.listCartresponseData = try JSONDecoder().decode(ListCartResponse.self, from: data2)
                    guard  let listCartresponseData = self.listCartresponseData else {return}
                    print(listCartresponseData)
                    completionHandler(listCartresponseData)
                }
                catch {
                    print(STRING.failToLoadData)
                }
            case .Error(let message):
                print(message)
            }
        }
    }
    
    func editCart(product_id:String,quantity : Int, completionHandler:@escaping (AddToCartResponse)->Void)
    {
        let url = STRING.editCartURL
        let header = true
        let para : [String: Any] = [STRING.product_id:"\(product_id)",
            STRING.quantity:quantity]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.editCartResponseData = try JSONDecoder().decode(AddToCartResponse.self, from: data2)
                    guard  let editCartResponseData = self.editCartResponseData else {return}
                    print(editCartResponseData)
                    completionHandler(editCartResponseData)
                }
                catch {
                    print(STRING.failToLoadData)
                }
            case .Error(let message):
                print(message)
            }
        }
    }
    
    func deleteCart(product_id:String ,completionHandler:@escaping (DeleteCartResponse)->Void)
    {
        let url = STRING.deleteCartURL
        let header = true
        let para : [String: Any] = [STRING.product_id:"\(product_id)"]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.deleteCartResponse = try JSONDecoder().decode(DeleteCartResponse.self, from: data2)
                    guard  let deleteCartResponse = self.deleteCartResponse else {return}
                    print(deleteCartResponse)
                    completionHandler(deleteCartResponse)
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
