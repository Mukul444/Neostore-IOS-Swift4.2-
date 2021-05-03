//
//  RateViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 18/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
class RateViewModel {
    // MARK:- Variables
    var responseData : RatingResponse?
    
    //MARK:- Functions and Methods
    func setRating(product_id:String,rate : Int, completionHandler:@escaping (RatingResponse?,Bool)->Void)
    {
        let url = STRING.rateURL
        let header = false
        let para : [String: Any] = [STRING.product_id : "\(product_id)",
                                    STRING.rating : rate]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpPostMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(RatingResponse.self, from: data2)
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
