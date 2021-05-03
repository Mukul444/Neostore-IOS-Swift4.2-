//
//  OrderViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 21/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

class OrderViewModel{
    //MARK:- Variables
    var orderResponse : OrderResponse?
    var viewFlag = true
    
     //MARK:- Functions and Methods
    func placeOrder(address:String,completionHandler:@escaping (OrderResponse?,Bool)->Void)
    {
        let url = STRING.placeOrderURL
        let header = true
        let para : [String: Any] = [STRING.address:"\(address)"]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.orderResponse = try JSONDecoder().decode(OrderResponse.self, from: data2)
                    guard  let orderResponse = self.orderResponse else {return}
                    print(orderResponse)
                    completionHandler(orderResponse,false)
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
