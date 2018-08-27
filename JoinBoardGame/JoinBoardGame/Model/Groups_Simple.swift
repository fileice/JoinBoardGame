//
//  Groups.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/17.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation
import Firebase

struct Group_New {
    
    var userId: String
    var cityName: String
    var gameClassType: String
    var gameName: String
    var groupEndTime: String
    var groupMax: String
    var groupMin: String
    var groupName: String
    var groupStartTime: String
    var shopName: String
    var userName: String
    var photoUrl: String
    var userPhotoUrl: String
    
    enum GroupInfoKey {
        static let cityName = "cityName"
        static let gameClassType = "gameClassType"
        static let gameName = "gameName"
        static let groupEndTime = "groupEndTime"
        static let groupMax = "groupMax"
        static let groupMin = "groupMin"
        static let groupName = "groupName"
        static let groupStartTime = "groupStartTime"
        static let shopName = "shopName"
        static let userName = "userName"
        static let photoUrl = "photoUrl"
        static let userPhotoUrl = "userPhotoUrl"
    }
    
    init(cityName: String, gameClassType: String, gameName: String, groupEndTime: String, groupMax: String, groupMin: String, groupName: String, groupStartTime: String, shopName: String, userName: String, photoUrl: String, userId: String, userPhotoUrl: String ) {
        self.cityName = cityName
        self.gameClassType = gameClassType
        self.gameName = gameName
        self.groupEndTime = groupEndTime
        self.groupMax = groupMax
        self.groupMin = groupMin
        self.groupName = groupName
        self.groupStartTime = groupStartTime
        self.shopName = shopName
        self.userName = userName
        self.photoUrl = photoUrl
        self.userId = userId
        self.userPhotoUrl = userPhotoUrl
    }
    
    init?(userId: String, groupInfo: [String: Any]) {
        guard let cityName = groupInfo[GroupInfoKey.cityName] as? String,
        let gameClassType = groupInfo[GroupInfoKey.gameClassType] as? String,
        let gameName = groupInfo[GroupInfoKey.gameName] as? String,
        let groupEndTime = groupInfo[GroupInfoKey.groupEndTime] as? String,
        let groupMax = groupInfo[GroupInfoKey.groupMax] as? String,
        let groupMin = groupInfo[GroupInfoKey.groupMin] as? String,
        let groupName = groupInfo[GroupInfoKey.groupName] as? String,
        let groupStartTime = groupInfo[GroupInfoKey.groupStartTime] as? String,
        let shopName = groupInfo[GroupInfoKey.shopName] as? String,
        let userName = groupInfo[GroupInfoKey.userName] as? String,
        let photoUrl = groupInfo[GroupInfoKey.photoUrl] as? String,
        let userPhotoUrl = groupInfo[GroupInfoKey.userPhotoUrl] as? String
        else {
            return nil
        }
        
        self = Group_New(cityName: cityName, gameClassType: gameClassType, gameName: gameName, groupEndTime: groupEndTime, groupMax: groupMax, groupMin: groupMin, groupName: groupName, groupStartTime: groupStartTime, shopName: shopName, userName: userName, photoUrl: photoUrl, userId: userId, userPhotoUrl: userPhotoUrl)
    }
}


