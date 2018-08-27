//
//  GameInfo.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/21.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation

class GameInfo {
    var tg_name: String?
    var tg_max: Double?
    var tg_min: Double?
}


//class GameInfo: NSObject {
//    var tg_name: String?
//    var tg_max: Int?
//    var tg_min: Int?
//    var tg_duration: Int?
//    var tg_introduction: String?
//
//}

class ShopInfo {
    
    var address: String?
    var closetime: String?
    var title: String?
    var map_longitude: String?
    var map_latitude: String?
    var tel: String?
    var opentime: String?

}


struct Area {
    var 前鎮區: String?
}


struct GameStruct {
    var tg_introduction: String?
    var tg_max: Int?
    var tg_min: Int?
    var tg_name: String?
    var photoUrl: String?
    var tg_class: String?
    
}


struct GameName {
    var 嘿我的魚: GameStruct?
    var 快手疊杯: GameStruct?
    var 拔毛運動會: GameStruct?
    var 超級犀牛: GameStruct?
    var 伐木達人: GameStruct?
    var 作弊飛蛾: GameStruct?
    var 語破天機: GameStruct?
    var 魔城馬車: GameStruct?
}

struct GameClass {
    var 兒童親子: [GameName]?
    var 家庭聚會: [GameName]?
    var 派對聯誼: [GameName]?
}







