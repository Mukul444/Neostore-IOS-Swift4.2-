//
//  MyAccountViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 12/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

class ProductListViewModel {
    // MARK:- Variables
    var responseData : ProductList?
    
    //MARK:- Functions and Methods
    func getProductDetails(product_category_id:String, completionHandler:@escaping (ProductList)->Void)
    {
        var url1 = URLComponents(string: STRING.getProductListURL)
        url1!.queryItems = [
            URLQueryItem(name: STRING.product_category_id, value: "\(product_category_id)")
        ]
        url1!.percentEncodedQuery = url1!.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = url1?.url?.absoluteString else{print(STRING.urlIsNotPrepared)
            return}
        let header = false
        let para : [String: Any] = [:]
        let  api = HttpMethods()
        api.setupPostMethod(urlFromModel:url, parameter:para, method:STRING.httpGetMethod, header:header){ (result) in
            switch result {
            case .Success(let data):
                let data2 = data as! Foundation.Data
                do{
                    self.responseData = try JSONDecoder().decode(ProductList.self, from: data2)
                    guard  let responseData = self.responseData else {return}
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
