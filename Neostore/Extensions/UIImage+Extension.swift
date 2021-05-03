//
//  UIImage+Extension.swift
//  Neostore
//
//  Created by webwerks1 on 22/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit
public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    public func toBase64(format: ImageFormat) -> String? {
        var imageData: Foundation.Data?
        
        switch format {
        case .png:
            imageData = self.pngData()
        case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
    }
}
extension UIImage{
    func getImageFromUrl(picUrl:String)->UIImage{
        var image : UIImage?
        if let url = URL(string:(picUrl)){
            if let data = try? Foundation.Data(contentsOf: url){
             image  = UIImage(data: data)!
        }
        }
        return image ?? UIImage(named: IMAGE.user_male)!
    
    }
}
