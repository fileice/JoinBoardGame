//
//  FireBaseFactory.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/27.
//  Copyright © 2018年 fileice. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    
    struct UploadToGroups {
        
        static let databaseRoot = Database.database().reference()
        static let databaseGropus = databaseRoot.child("groups")
    }
    
    struct UploadToGroup_simple {
        static let databaseRoot = Database.database().reference()
        static let databaseGropus = databaseRoot.child("group_simple")
    }
    
    struct Chat_Ref {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
    
    struct User_Ref {
        static let databaseRoot = Database.database().reference()
        static let databaseUsers = databaseRoot.child("users")
    }
    
    struct GroupChat_Ref {
        static let databaseRoot = Database.database().reference()
        static let databaseGroupChat = databaseRoot.child("chat")
    }
    
}


final class Group_SimpleService {
    
    static let shared: Group_SimpleService = Group_SimpleService()
    private init () {}
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let GROUP_DB_REF: DatabaseReference = Database.database().reference().child("group_simple")
    
    func getRecentPosts(completionHandler: @escaping ([Group_New]) -> Void) {
        
        // 呼叫 Firebase API 來取得最新的資料記錄
        let groupQuery = GROUP_DB_REF
        groupQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var newPosts: [Group_New] = []
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let groupInfo = item.value as? [String: Any] ?? [:]
                
                if let group = Group_New(userId: item.key, groupInfo: groupInfo) {
                    newPosts.append(group)
                }
            }
            
            
            completionHandler(newPosts)
        })
    }
}

final class GroupService {
    
    static let shared: GroupService = GroupService()
    private init () {}
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let GROUP_DB_REF: DatabaseReference = Database.database().reference().child("groups")
    
    func getRecentPosts(completionHandler: @escaping ([Group_Two]) -> Void) {
        
        // 呼叫 Firebase API 來取得最新的資料記錄
        let groupQuery = GROUP_DB_REF
        groupQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var newPosts: [Group_Two] = []
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let groupInfo = item.value as? [String: Any] ?? [:]
                
                if let group = Group_Two(userId: item.key, groupInfo: groupInfo) {
                    newPosts.append(group)
                }
            }
            completionHandler(newPosts)
        })
    }
}





