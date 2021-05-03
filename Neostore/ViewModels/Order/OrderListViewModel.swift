//
//  OrderListViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 21/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
class OrderListViewModel{
    //MARK:- Variables
    var orderListResponse : OrderListResponse?
    
     //MARK:- Functions and Methods
    func listOrder(completionHandler:@escaping (OrderListResponse)->Void)
    {
        let url = STRING.orderListURL
        let header = true
        let para : [String: Any] = [:]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpGetMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.orderListResponse = try JSONDecoder().decode(OrderListResponse.self, from: data2)
                    guard  let orderListResponse = self.orderListResponse else {return}
                    print(orderListResponse)
                    completionHandler(orderListResponse)
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
