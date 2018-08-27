//
//  Groups.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/18.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation
import Firebase

struct Group_Two {
    
    var userId: String
    var map_latitude: String
    var map_longtitude: String
    var shopAddress: String
    var shopTel: String
    var opentime: String
    var closetime: String
    
    enum GroupInfoKey {
        static let map_latitude = "map_latitude"
        static let map_longtitude = "map_longtitude"
        static let shopAddress = "shopAddress"
        static let shopTel = "shopTel"
        static let opentime = "opentime"
        static let closetime = "closetime"
    }
    
    init(map_latitude: String, map_longtitude: String, shopAddress: String, shopTel: String, opentime: String, closetime: String, userId: String ) {
        self.map_longtitude = map_longtitude
        self.map_latitude = map_latitude
        self.shopAddress = shopAddress
        self.shopTel = shopTel
        self.opentime = opentime
        self.closetime = closetime
        self.userId = userId
    }
    
    init?(userId: String, groupInfo: [String: Any]) {
        guard let map_latitude = groupInfo[GroupInfoKey.map_latitude] as? String,
            let map_longtitude = groupInfo[GroupInfoKey.map_longtitude] as? String,
            let shopAddress = groupInfo[GroupInfoKey.shopAddress] as? String,
            let shopTel = groupInfo[GroupInfoKey.shopTel] as? String,
            let opentime = groupInfo[GroupInfoKey.opentime] as? String,
            let closetime = groupInfo[GroupInfoKey.closetime] as? String
            else {
                return nil
        }
        
        self = Group_Two(map_latitude: map_latitude, map_longtitude: map_longtitude, shopAddress: shopAddress, shopTel: shopTel, opentime: opentime, closetime: closetime, userId: userId)
    }
}
