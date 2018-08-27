//
//  GroupChatViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/20.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class GroupChatViewController: JSQMessagesViewController {
    
    let currentUser = Auth.auth().currentUser
    var messages = [JSQMessage]()
    var otherUserArray = [String]()
    var chatName: String = ""
    var groupId: String = ""
    var senderImageUrl: String = ""

    
    var incomingAvatar: JSQMessagesAvatarImage!
    var outcomingAvatar: JSQMessagesAvatarImage!
    var dateTime: String = ""
    
    var userPhouoUrl: String = ""

    var memberPhotoUrl: String = ""
    var memberDict = [String: Any]()
    

    var members = [Members]()

    
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
        title = chatName
        
        inputToolbar.contentView.leftBarButtonItem = nil
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateNow: Date = Date()
        self.dateTime = dateFormatter.string(from: dateNow)
        //print(dateTime)
        

        //Do any additional setup after loading the view.
        //collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        //collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        

        
        
        let photoRef = Constants.User_Ref.databaseUsers.child((currentUser?.uid)!)
        photoRef.observeSingleEvent(of: .value) { (snapshot) in

            if let usersDict = snapshot.value as? [String: Any]{
                let userurl = usersDict["photoUrl"] as! String
                self.memberPhotoUrl = userurl
                let userImageURL = URL(string: userurl)
                let userImageData: Data = try! Data(contentsOf: userImageURL!)
                self.outcomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: userImageData), diameter: 64)
            }
        }
//
        

        
//
//        let userRef = Database.database().reference()
//
//        userRef.child("group_simple").child(self.groupId).child("members").observe(DataEventType.childAdded, with: { (snapshot) in
//            self.memberDict = snapshot.value as! [String : Any]
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        
        
        
        
        //otheruser photo
//        let otherImageURL: URL = URL(string: self.useroPhouoUrl)!
//        let otherImageData: Data = try! Data(contentsOf: otherImageURL)
//        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: otherImageData), diameter: 64)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeMessages()
        //loadPhoto()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return JSQMessagesAvatarImageFactory.avatarImage(
            withUserInitials: messages[indexPath.row].senderDisplayName,
            backgroundColor: UIColor.lightGray, textColor: UIColor.white,
            font: UIFont.systemFont(ofSize: 14), diameter: 80)
        
//        let message = self.messages[indexPath.item]
//
//        if message.senderId == self.senderId {
//
//            return self.outcomingAvatar
//        }
//        return self.incomingAvatar
        
        //print(self.imgUrl)
    }
    

    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        //        return messages[indexPath.item].senderId == senderId ? NSAttributedString(string: messages[indexPath.item].senderDisplayName) : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
        let message = self.messages[indexPath.item]
        return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return 13.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            cell.textView.textColor = UIColor.white
        } else {
            cell.textView.textColor = UIColor.black
        }
        return cell
    }
    
    //圖片下標示名稱
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return messages[indexPath.item].senderId == senderId ? NSAttributedString(string: messages[indexPath.item].senderDisplayName) : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    //開啟顯示高度 預設＝0 無法顯示
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        return 13
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.GroupChat_Ref.databaseGroupChat.child("\(self.groupId)").childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text, "time": dateTime, "photoUrl":memberPhotoUrl]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }
    
    
    func addMessage(id: String, displayName: String, text: String, photoUrl: String) {
        let message = JSQMessage(senderId: senderId, displayName: displayName, text: text)
        
        messages.append(message!)
    }
    
    private func observeMessages() {
        let messageQuery = Constants.GroupChat_Ref.databaseGroupChat.child("\(self.groupId)").queryLimited(toLast: 25)
        
        messageQuery.observe(.childAdded) { (snapshot) in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self.messages.append(message)
                    
                    self.finishReceivingMessage()
                }
            }
        }
    }
    
    
}
