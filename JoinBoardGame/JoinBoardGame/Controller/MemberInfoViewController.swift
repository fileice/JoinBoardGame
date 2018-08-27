//
//  MemberInfoViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseStorage
import FirebaseDatabase


class MemberInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberInfoTableView: UITableView!
    var userName: String = ""
    var uid: String = ""
    var umail: String = ""
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var userInfoTextFiled: UITextField!

    @IBAction func btnSave_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnUpLoadPic(_ sender: UIButton) {
        // 建立一個 UIImagePickerController 的實體
        let imagePickerController = UIImagePickerController()
        
        // 委任代理 //需實作potocol
        imagePickerController.delegate = self
        
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in
            
            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in
            
            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        // 將上面三個 UIAlertAction 動作加入 UIAlertController
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true, completion: nil)
    }
    

    //登出
    @IBAction func btnLogout_Click(_ sender: Any) {
        do {
            if let providerData = Auth.auth().currentUser?.providerData {
                let userInfo = providerData[0]
                
                switch userInfo.providerID {
                case "google.com":
                        GIDSignIn.sharedInstance().signOut()
                default:
                    break
                }
            }
            try Auth.auth().signOut()
            
        } catch {
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // 呈現歡迎視圖
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //判斷是否為會員
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            self.showMessage(messageToDisplay: "要使用此功能請先註冊會員")
            return
        }

        if let currentUser = Auth.auth().currentUser {
            userName = currentUser.displayName!
            uid = currentUser.uid
            umail = currentUser.email!
            
            //顯示大頭貼圖示
            if currentUser.photoURL != nil {
                DispatchQueue.global().async {
                    let imgData = try? Data(contentsOf: (currentUser.photoURL)!)

                    DispatchQueue.main.async {
                        if let data = imgData{
                            let image = UIImage(data: data)
                            self.memberImageView.image = image
                        }
                    }
                }
            }
        }
        
        loadAvatar()
 
        memberImageView.contentMode = .scaleAspectFill
        
        self.memberInfoTableView.delegate = self
        self.memberInfoTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAvatar() {
        //load avatar
        let storageReference = Storage.storage().reference()
        let currentUser = Auth.auth().currentUser
        
        let profileImageRef = storageReference.child("UserInfo").child(currentUser!.uid).child("profileImage.jpg")
        
        profileImageRef.getData(maxSize: 2 * 2048 * 2048) { (data, error) in
            if let error = error {
                print("error \(error)")
            } else {
                if let imageData = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.memberImageView.image = image
                    }
                }
            }
        }//end data,error closure
    }//end loadAvatar

    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    public func showMessage(messageToDisplay: String){
        
        let alertController = UIAlertController(title: "Alert title", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        {
            (Void) in
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberInfoView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }//end showMessage

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    /*********** start ableView delegate Potocol ************/
    func numberOfSections(in tableView: UITableView) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var rowNum: Int = 0
//        if section == 0 {
//            rowNum = 1
//        } else if section == 1 {
//
//        } else if section == 2 {
//
//        }
//
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "姓名 ： \(userList[indexPath.row].user!)"
            
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "自我介紹 ： \(userList[indexPath.row].introduction!)"
        } else if indexPath.section == 2 {
            
        }
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let myVCUserModify: ModifyUserInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcModifyUserInfo") as! ModifyUserInfoViewController
            myVCUserModify.strMsg = userList[indexPath.row].user!
            myVCUserModify.strTitle = "姓名"
            self.navigationController?.show(myVCUserModify, sender: nil)
        } else if indexPath.section == 1 {
            let myVCUserModify: ModifyUserInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcModifyUserInfo") as! ModifyUserInfoViewController
            myVCUserModify.strMsg = userList[indexPath.row].introduction!
            myVCUserModify.strTitle = "自我介紹"
            self.navigationController?.show(myVCUserModify, sender: nil)
        }
    }
    
    
    
    //vcModifyUserInfo
    
    /*********** end ableView delegate Potocol ************/

    var userList = [UserInfo]()
    var userInfos = [String: AnyObject]()
    var userArray = [String]()
    
    func loadData() {
        self.userList.removeAll()
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let userRef = Database.database().reference()
            userRef.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myuserDict = snapshot.value as? [String:AnyObject] {
                    
                    for(_,_) in myuserDict {
                        let newuser = UserInfo()
                        newuser.user = myuserDict["user"] as? String
                        newuser.introduction = myuserDict["introduction"] as? String
                        self.userList.append(newuser)
                    }
                }
                self.memberInfoTableView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }//end loaddata
    
    
}//end class MemberInfoViewController:


//UIImagePickerController delegate
extension MemberInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    ////把圖存成物件
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let profileImage = info[UIImagePickerControllerOriginalImage] as? UIImage, let optimizedImageData = UIImageJPEGRepresentation(profileImage, 1.0) {
            uploadProfileImage(imageData: optimizedImageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileImage(imageData: Data) {
        //上傳指標
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        activityIndicator.color = UIColor.red
        self.view.addSubview(activityIndicator)
        
        //變更storage圖片
        let storageReference = Storage.storage().reference()
        let currentUser = Auth.auth().currentUser
        let profileImageRef = storageReference.child("UserInfo").child(currentUser!.uid).child("profileImage.jpg")
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        
        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            if error != nil {
                print("Error\(String(describing: error?.localizedDescription))")
                return
            } else {

                //load userPhoto
                let currentUser = Auth.auth().currentUser
                let storageReference = Storage.storage().reference()
                let userPhotoRef = storageReference.child("UserInfo").child(currentUser!.uid).child("profileImage.jpg")
                
                userPhotoRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        return
                    } else {
                        let url = url?.absoluteString
                        _ = Constants.User_Ref.databaseUsers.child(currentUser!.uid).child("photoUrl").setValue(url)
                    }
                })

                userPhotoRef.getData(maxSize: 2 * 2048 * 2048) { (data, error) in
                    if let error = error {
                        print("error \(error)")
                    } else {
                        if let imageData = data {
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                self.memberImageView.image = image
                            }
                        }
                    }
                }//end data,error closure

                print("Meta data of uploaded imagae \(String(describing: uploadMetaData))")
            }
        }//end closure
    }//end uploadProfileImage
}//end UIImagePickerController delegate














