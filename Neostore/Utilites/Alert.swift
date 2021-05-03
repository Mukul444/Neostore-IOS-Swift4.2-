//
//  Alert.swift
//  Neostore
//
//  Created by webwerks1 on 23/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit
enum Action{
    case dismiss 
    case segue
    case popover
    case doNothing
}
class Alert {
    
    var actionEnum : Action?
    public class func alertPopUp(identifier : String?, message : String, actionEnum: Action, viewController : UIViewController)  {
        // create the alert
        let alert = UIAlertController(title: "Successfull", message: message, preferredStyle: UIAlertController.Style.alert)
       
        switch actionEnum {
        case .dismiss:
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
                viewController.dismiss( animated: true, completion: nil)
            })
            alert.addAction(action)
            
        case .segue:
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
                viewController.performSegue(withIdentifier: identifier ?? "noIdentifier", sender: viewController)
            })
            alert.addAction(action)
        case .popover:
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
                viewController.navigationController?.popViewController(animated: true)
            })
            alert.addAction(action)
            
        case .doNothing:
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public class func failPopUp(message : String,viweControler : UIViewController)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Unsuccessfull", message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            viweControler.present(alert, animated: true, completion: nil)
        }
    }
    
}
