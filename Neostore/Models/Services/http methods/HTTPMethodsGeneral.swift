//
//  HTTPMethodsGeneral.swift
//  Neostore
//
//  Created by webwerks1 on 06/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import KeychainSwift
import UIKit


class HttpMethods{
    //MARK:- Variables
    
    var parameterBool : Bool = true
    var keychain = KeychainSwift()
    
    
    
    //MARK:- Functions
    func setupPostMethod(urlFromModel : String ,parameter : [String : Any] ,method : String,header : Bool,completion : @escaping (Result<Any>) -> Void){
        
        if let url = URL(string: urlFromModel){
            var request = URLRequest(url: url)
            request.httpMethod = method
            if(header)
            {
                request.setValue(keychain.get(STRING.access_token)!, forHTTPHeaderField: STRING.access_token)
            }
            let parameters: [String : Any] = parameter
            if(!(parameters.isEmpty))
            {
                request.httpBody = parameters.percentEscaped().data(using: .utf8)
            }
            
            let   task =  URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else
                {
                    if error == nil
                    {
                        print(error?.localizedDescription ?? STRING.unknownError)
                    }
                    return
                }
                if let response = response as? HTTPURLResponse
                {
                    print("\(STRING.statusCode) :- \(response.statusCode)")
                    completion(.Success(data))
                }
            }
            task.resume()
        }
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

enum Result <T>{
    case Success(T)
    case Error(String)
}


