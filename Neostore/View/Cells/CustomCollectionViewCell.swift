//
//  CustomCollectionViewCell.swift
//  Neostore
//
//  Created by webwerks1 on 18/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    // MARK : - Variables
        static let identifier = STRING.customCollectionViewCellIdentifier
        var myImageView : UIImageView? = {
        let image = UIImageView()
        image.image = UIImage(named: IMAGE.sofa_icon)
        return image  
    }()
    
    override init(frame  : CGRect){
        super.init(frame : frame)
        contentView.addSubview(myImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView?.frame = CGRect(x: 0,
                                    y: 0,
                                    width: contentView.frame.size.width,
                                    height: contentView.frame.size.height)
    }
    public func imageName (imageFromArray : UIImage){
        myImageView?.image = imageFromArray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView?.image = nil
    }
    
    
}
