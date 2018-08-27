//
//  SingUpViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var myNameTextField: UITextField!
    @IBOutlet weak var myMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userName: String = ""
    var ref: DatabaseReference!
    let defaultUserPhoroUrl: String = "https://firebasestorage.googleapis.com/v0/b/joinboardgame-91903.appspot.com/o/UserInfo%2FdefaultUserPhoto%2Fuser_256.png?alt=media&token=d80d144c-5623-44ff-aa08-93e2aead9f52"
    

    @IBAction func btnMailLoginFirebase(_ sender: UIButton) {
        
        // 輸入驗證
        guard let name = myNameTextField.text, name != "",
            let emailAddress = myMailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                let alertController = UIAlertController(title: "Registration Error", message: "請確保您提供的暱稱，電子郵件地址和密碼無空白已完成註冊。", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                return
        }

        // 在 Firebase 註冊使用者帳號
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: { (user, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            //var userList = [UserInfo]()
            // 將登入的username存放至firebase database
            let currentUser = Auth.auth().currentUser
            self.ref.child("users").child(currentUser!.uid).child("user").setValue(self.myNameTextField.text)

            //self.ref.child("users").child(currentUser!.uid).child("introduction").setValue(" ")
            if currentUser != nil {
                
                let userRef = Database.database().reference()
                userRef.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.hasChild("introduction") {
                        //do nothing
                    } else {
                        self.ref.child("users").child(currentUser!.uid).child("introduction").setValue(" ")
                    }
                    self.ref.child("users").child(currentUser!.uid).child("photoUrl").setValue(self.defaultUserPhoroUrl)

                }) { (error) in
                    print(error.localizedDescription)
                }
            }

            let userePhotoRef = Storage.storage().reference()
            let profileImageRef = userePhotoRef.child("UserInfo").child(currentUser!.uid).child("profileImage.jpg")
            
            let image = UIImage(named: "user_256")
            let data = UIImagePNGRepresentation(image!)
            profileImageRef.putData(data!)
            
            
            
            // 儲存使用者的名稱
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Failed to change the display name: \(error.localizedDescription)")
                    }
                })
            }
            
            // 移除鍵盤
            self.view.endEditing(true)
            
            // 呈現主視圖
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    var userList = [UserInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
