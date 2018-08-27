//
//  NewChatViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/15.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase
import FirebaseDatabase

class NewChatViewController: JSQMessagesViewController {
    let currentUser = Auth.auth().currentUser
    var messages = [JSQMessage]()
    var otherUserName: String = ""
    
    var incomingAvatar: JSQMessagesAvatarImage!
    var outcomingAvatar: JSQMessagesAvatarImage!
    
    
    var userPhouoUrl: String = ""
    var otherUserPhotoUrl: String = ""
    
    var receiverId: String = ""
    var convoId: String = ""
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
//    var userIsTypingRef: AnyObject?
//    private var locolTyping = false
//
//    var isTyping: Bool {
//        get {
//            return locolTyping
//        }
//        set {
//            locolTyping = newValue
//            self.usefrIsTypingRef!.setValue(newValue)
//        }
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senderId = currentUser?.uid
        title = otherUserName
        senderDisplayName = currentUser?.displayName
        
        inputToolbar.contentView.leftBarButtonItem = nil
        
//        print(self.senderId)
//        print(self.receiverId)
       
        //setupBubbles()
        // Do any additional setup after loading the view.
        //collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        //collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        //print(self.otherUserPhotoUrl)
        //print("\(self.userPhouoUrl)++++++++++++++++++++")
        
//        let receiverIdFive = String(self.receiverId.prefix(5))
//        let senderIdFive = String(self.senderId.prefix(5))
        
        
        
        let receiverIdFive = String(self.receiverId)
        let senderIdFive = String(self.senderId)
        
        if (senderIdFive > receiverIdFive) {
            self.convoId = senderIdFive + receiverIdFive
        } else {
            self.convoId = receiverIdFive + senderIdFive
        }
        
        //user photo
        let photoRef = Constants.User_Ref.databaseUsers.child((currentUser?.uid)!)
        photoRef.observeSingleEvent(of: .value) { (snapshot) in
            
            if let usersDict = snapshot.value as? [String: Any]{
                let userurl = usersDict["photoUrl"] as! String
                let userImageURL = URL(string: userurl)
                let userImageData: Data = try! Data(contentsOf: userImageURL!)
                self.outcomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: userImageData), diameter: 64)
            }
        }

        //otheruser photo
        let otherImageURL: URL = URL(string: self.otherUserPhotoUrl)!
        let otherImageData: Data = try! Data(contentsOf: otherImageURL)
        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: otherImageData), diameter: 64)
        
        
//        if otherImageURL.isFileURL == false {
//            let otherImageData: Data = try! Data(contentsOf: otherImageURL)
//            self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(data: otherImageData), diameter: 64)
//
//        } else {
//            self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "user_256"), diameter: 64)
//        }
        
        
        
        
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
        let message = self.messages[indexPath.item]
        
        if message.senderId == self.senderId {
            
            return self.outcomingAvatar
        }
        return self.incomingAvatar
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

    //add new message
    func addMessage(id: String, displayName: String, text: String) {
        let message = JSQMessage(senderId: senderId, displayName: displayName, text: text)
        messages.append(message!)
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.Chat_Ref.databaseChats.child("\(self.convoId)").childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }
    
    private func observeMessages() {
        let messageQuery = Constants.Chat_Ref.databaseChats.child("\(self.convoId)").queryLimited(toLast: 25)
        
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
    
//    override func textViewDidChange(_ textView: UITextView) {
//        super.textViewDidChange(textView)
//        isTyping = textView.text != ""
//    }
//
//    private func observerTyping() {
//        let typingIndicatorRef = Constants.Chat_Ref.databaseChats.child("\(self.convoId)").child("typingIndicator")
//        userIsTypingRef = typingIndicatorRef.child(senderId)
//        userIsTypingRef?.onDisconnectRemoveValue()
//
//        let userTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqual(toValue: true)
//
//        userTypingQuery.observe(.value) { (snapshot: DataSnapshot) in
//
//            if snapshot.childrenCount == 1 && self.isTyping {
//                return
//            }
//
//            self.showTypingIndicator = snapshot.childrenCount > 0
//            self.scrollToBottom(animated: true)
//
//        }
//    }


    
    
//    override func didPressAccessoryButton(_ sender: UIButton!) {
//        selectImage()
//        print("aaa")
//    }
//    private func selectImage() {
//        let alertController = UIAlertController(title: "画像を選択", message: nil, preferredStyle: .actionSheet)
//        let cameraAction = UIAlertAction(title: "カメラを起動", style: .default) { (UIAlertAction) -> Void in
//            self.selectFromCamera()
//        }
//        let libraryAction = UIAlertAction(title: "カメラロールから選択", style: .default) { (UIAlertAction) -> Void in
//            self.selectFromLibrary()
//        }
//        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) -> Void in
//            self.dismiss(animated: true, completion: nil)
//        }
//        alertController.addAction(cameraAction)
//        alertController.addAction(libraryAction)
//        alertController.addAction(cancelAction)
//    }
//
//    private func selectFromCamera() {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
//            imagePickerController.allowsEditing = true
//            self.present(imagePickerController, animated: true, completion: nil)
//        } else {
//            print("カメラ許可をしていない時の処理")
//        }
//    }
//
//    private func selectFromLibrary() {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePickerController.allowsEditing = true
//            self.present(imagePickerController, animated: true, completion: nil)
//        } else {
//            print("カメラロール許可をしていない時の処理")
//        }
//    }
//
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let image = info[UIImagePickerControllerEditedImage] {
//            sendImageMessage(image: image as! UIImage)
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//    private func sendImageMessage(image: UIImage) {
//        let photoItem = JSQPhotoMediaItem(image: image)
//        let imageMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photoItem)
//        messages.append(imageMessage!)
//        finishSendingMessage(animated: true)
//    }
    
    
    
    
    
}












