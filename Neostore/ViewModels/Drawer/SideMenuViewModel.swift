//
//  SideMenuViewModel.swift
//  Neostore
//
//  Created by webwerks1 on 27/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
import UIKit
class SideMenuViewModel{
    public static let menuArray = [STRING.MyCart,
                                  STRING.Table,
                                  STRING.Sofa,
                                  STRING.Chair,
                                  STRING.Cupboard,
                                  STRING.MyAccount,
                                  STRING.StoreLocator,
                                  STRING.MyOrders,
                                  STRING.Address,
                                  STRING.Logout]
    
    public static let menuIcons = [UIImage(named: IMAGE.shoppingcart_icon),
                                   UIImage(named: IMAGE.table),
                                   UIImage(named: IMAGE.sofa),
                                   UIImage(named: IMAGE.chair),
                                   UIImage(named: IMAGE.cupboard),
                                   UIImage(named: IMAGE.username_icon),
                                   UIImage(named: IMAGE.storelocator_icon),
                                   UIImage(named: IMAGE.myorders_icon),
                                   UIImage(named: IMAGE.house),
                                   UIImage(named: IMAGE.logout_icon)]
}
