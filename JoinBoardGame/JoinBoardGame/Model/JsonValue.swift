//
//  JsonValue.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/6.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation

struct JsonSalver {
    var list = [GameAnswer]()
    
    init() {
        /* let word = Vocabulary(wordCh: "吃漢", wordEng: "eater")
         list.append(word)*/
    }
}


struct JsonSlave: Decodable {
    
    let fid: Int
    let fName: String
    let fPhone: String
    let fEmail: String
    let fAddress: String
}

class JsonAnswer {
    let fid: Int
    let fName: String
    let fPhone: String
    let fEmail: String
    let fAddress: String
    
    init(fid: Int, fName: String, fPhone: String, fEmail: String, fAddress: String) {
        self.fid = fid
        self.fName = fName
        self.fEmail = fEmail
        self.fPhone = fPhone
        self.fAddress = fAddress
    }
}
