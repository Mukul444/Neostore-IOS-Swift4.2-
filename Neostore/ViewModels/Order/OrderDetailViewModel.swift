//
//  OrderDetailViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 22/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

class OrderDetailViewModel {
    // MARK:- Variables
    var orderDetailResponse : OrderDetailResponse?
    
    //MARK:- Functions and Methods
    func getorderDetails(order_id:String, completionHandler:@escaping (OrderDetailResponse)->Void)
    {
        var url1 = URLComponents(string: STRING.orderDetailsURL)
        url1!.queryItems = [
            URLQueryItem(name: STRING.order_id, value: "\(order_id)")
        ]
        url1!.percentEncodedQuery = url1!.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = url1?.url?.absoluteString else{print(STRING.urlIsNotPrepared)
            return}
        let header = true
        let para : [String: Any] = [:]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpGetMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.orderDetailResponse = try JSONDecoder().decode(OrderDetailResponse.self, from: data2)
                    guard  let orderDetailResponse = self.orderDetailResponse else {return}
                    print(orderDetailResponse)
                    completionHandler(orderDetailResponse)
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
