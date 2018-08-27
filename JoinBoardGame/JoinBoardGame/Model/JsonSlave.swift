//
//  JsonSlave.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/5.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation

struct GameDetailsStruct: Decodable {
    let tg_id: Int
    let tg_name: String
    let tg_max: Int
    let tg_min: Int
    let tg_class: String
    let tg_introduction: String
}

class GameAnswer {
    let tg_id: Int
    let tg_name: String
    let tg_max: Int
    let tg_min: Int
    let tg_class: String
    let tg_introduction: String
    
    init(tgid: Int, tgname: String, tgmax: Int, tgmin: Int, tgclass: String, tginstroduction: String){
        tg_id = tgid
        tg_name = tgname
        tg_max = tgmax
        tg_min = tgmin
        tg_class = tgclass
        tg_introduction = tginstroduction
    }
}






















