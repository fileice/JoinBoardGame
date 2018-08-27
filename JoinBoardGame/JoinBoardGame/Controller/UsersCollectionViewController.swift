//
//  UsersCollectionViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/12.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

private let reuseIdentifier = "CollectionViewCell"

class UsersCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var aivLoadingView: UIActivityIndicatorView!
    
    var databaseRef = Database.database().reference()
    var usersDict = NSDictionary()
    
    var currentUser = Auth.auth().currentUser
    
    var userNamesArray = [String]()
    var userPhotoArray = [String]()
    var userImageArray = [String]()
    var userDetailList = [UserDetails]()
    var userIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aivLoadingView.startAnimating()
      
        self.databaseRef.child("users").observe(.value, with: { (snapshot) in
            self.usersDict = (snapshot.value as? NSDictionary)!
            if let usersDict = snapshot.value as? [String: Any]{
                //print(usersDict)
                for(userid, detail) in usersDict {
                    if (detail as AnyObject).object(forKey: "user") != nil {
                        let name = (detail as AnyObject).object(forKey: "user")
                        self.userNamesArray.append(name as! String)
                        //print(self.userNamesArray)
                        self.userIdArray.append(userid)
                    }
                    
                    if (detail as AnyObject).object(forKey: "photoUrl") != nil {
                        let photoUrl = (detail as AnyObject).object(forKey: "photoUrl")
                        self.userPhotoArray.append(photoUrl as! String)
                        self.collectionView?.reloadData()
                    } 

                    //print(detail)
                    
                    self.aivLoadingView.stopAnimating()
                }
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.userNamesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UsersCollectionViewCell
        
        cell.lbluserName.text = userNamesArray[indexPath.row]
        
        if let url = URL(string: userPhotoArray[indexPath.row]) {
            let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                
                OperationQueue.main.addOperation {
                    guard let image = UIImage(data: imageData) else { return }
                    
                    //加入圖片至快取
                    cell.userImageView.image = image
                    CacheManager.shared.cache(object: image, key: self.userPhotoArray[indexPath.row])
                }
            }
            downloadTask.resume()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let newChatVC: NewChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "Chat") as! NewChatViewController
        if let navigator = navigationController {
            newChatVC.hidesBottomBarWhenPushed = true
            newChatVC.otherUserName = self.userNamesArray[indexPath.item]
            newChatVC.receiverId = self.userIdArray[indexPath.item]
            newChatVC.otherUserPhotoUrl = self.userPhotoArray[indexPath.item]
            
            navigator.pushViewController(newChatVC, animated: true)
            //self.navigationController?.show(newChatVC, sender: nil)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        let navVC = segue.destination as! UINavigationController
//        let chatVC = navVC.viewControllers.first as! NewChatViewController
//
//        chatVC.senderId = self.currentUser?.uid
//        chatVC.receiverData = sender as! Any.Protocol
//        chatVC.senderDisplayName = sender as! String
//
//    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
