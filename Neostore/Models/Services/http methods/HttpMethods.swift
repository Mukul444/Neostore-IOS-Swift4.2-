//
//  HttpMethods.swift
//  Neostore
//
//  Created by webwerks1 on 05/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit

struct Http{
    func setupPostMethod(completion :@escaping (Result<[[String: AnyObject]]>) -> Void){
        
        if let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/change"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
               request.setValue("606c9b3641f8b", forHTTPHeaderField: "access_token")
            let parameters: [String : Any] = [
                "old_password":"pass123",
                "password":"pass1234",
                "confirm_password":"pass1234"
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        //print(response)
                        return
                    }
                }
                
                do{
                    // old type
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                   // print(json)
                    
                }catch let error{
                    print(error.localizedDescription)
                }
                do {// new type
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(UserData.self, from: data)
                    print(responseModel)
                } catch let error {
                    return completion(.Error(error.localizedDescription))
                }
                }.resume()
        }
    }
}




