//
//  GroupDetail.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/30.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation
import FirebaseAuth

//class Group_Simple {
//    
//    var cityName: String?
//    var gameClassType: String?
//    var gameName: String?
//    var groupEndTime: String?
//    var groupMax: String?
//    var groupMin: String?
//    var groupName: String?
//    var groupStartTime: String?
//    var shopName: String?
//    var userName: String?
//}

struct Group_Simple {
    
    var cityName: String?
    var gameClassType: String?
    var gameName: String?
    var groupEndTime: String?
    var groupMax: String?
    var groupMin: String?
    var groupName: String?
    var groupStartTime: String?
    var shopName: String?
    var userName: String?
    var boardGamePhotoUrl: String?
    var userId: String?
    var userPhotoUrl: String?
}

struct Groups {
    var map_latitude: String?
    var map_longtitude: String?
    var shopAddress: String?
    var shopTel: String?
    var opentime: String?
    var closetime: String?
}

struct Group_All {
    var cityName: String?
    var gameClassType: String?
    var gameName: String?
    var groupEndTime: String?
    var groupMax: String?
    var groupMin: String?
    var groupName: String?
    var groupStartTime: String?
    var shopName: String?
    var userName: String?
    var map_latitude: String?
    var map_longtitude: String?
    var shopAddress: String?
}

struct Members {
    var name: String?
    var userPhotoUrl: String?
}
//class ShopInfo {
//
//    var address: String?
//    var closetime: String?
//    var title: String?
//    var map_longitude: String?
//    var map_latitude: String?
//    var tel: String?
//    var opentime: String?
//
//}


//class Groups {
//    let map_latitude: String?
//    let map_longtitude: String?
//    let shopAddress: String?
//}
