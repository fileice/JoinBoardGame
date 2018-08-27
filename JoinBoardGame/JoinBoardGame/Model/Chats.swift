//
//  Chats.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation

class Chats {
    
    var userName: String?
    var message: String?
    var time: String?
    
    init (data: NSDictionary) {
        userName = data["username"] as? String ?? ""
        message = data["message"] as? String ?? ""
        time = data["time"] as? String ?? ""
    }
    
}

struct GroupChatPhotoUrl {
    var userPhotoUrl: String?
}
