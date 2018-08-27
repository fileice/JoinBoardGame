//
//  ChatsViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/8.
//  Copyright © 2018年 fileice. All rights reserved.
//
//聊天界面,使用 JSQMessages 不建議使用

import UIKit
import JSQMessagesViewController
import FirebaseAuth
import Firebase

class ChatsViewController: JSQMessagesViewController {
    
    let currentUser = Auth.auth().currentUser
    
    var messages = [JSQMessage]()
    //大頭貼宣告
    var incomingAvatar: JSQMessagesAvatarImage!
    var outcomingAvatar: JSQMessagesAvatarImage!
    
    var chats = [Chats]()
    
    //聊天泡泡視窗顏色
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        senderId = currentUser?.uid
        senderDisplayName = currentUser?.displayName
 
        
        let storageRef = Storage.storage().reference()
        let userPhotoRef = storageRef.child("UserInfo").child(currentUser!.uid).child("profileImage.jpg")
        //顯示大頭貼圖示
        userPhotoRef.downloadURL { (url, error) in
            if error == nil {
                
                let myImageURL: URL = URL(string: (url?.absoluteString)!)!
                let myImageData: Data = try! Data(contentsOf: myImageURL)
                
                //self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: myImageData), diameter: 64)
                self.outcomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: myImageData), diameter: 64)
            } else {
                
                if self.currentUser?.photoURL != nil {
                    DispatchQueue.global().async {
                        let myImageData = try? Data(contentsOf: (self.currentUser?.photoURL)!)
                        
                        //self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: myImageData!), diameter: 64)
                        self.outcomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: myImageData!), diameter: 64)
                    }
                }
            }
        }
        
        title = "Chat: \(senderDisplayName!)"
        
        //檔案上傳按鈕,未實作,
        inputToolbar.contentView.leftBarButtonItem = nil
        //collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        //collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        //讀取聊天訊息
        let query = Constants.Chat_Ref.databaseChats.queryLimited(toLast: 10)
        
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        
        let message = self.messages[indexPath.item]

        if message.senderId == self.senderId {
            
            return self.outcomingAvatar
        }
        return self.incomingAvatar
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
//        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
        
        let message = messages[indexPath.row]
        let messageUserName = message.senderDisplayName
        return NSAttributedString(string: messageUserName!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.Chat_Ref.databaseChats.childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }
    
}
