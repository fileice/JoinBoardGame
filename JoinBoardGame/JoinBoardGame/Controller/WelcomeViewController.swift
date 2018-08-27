//
//  WelcomeViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class WelcomeViewController: UIViewController {
    var ref: DatabaseReference!
   
    
    @IBAction func btnBack_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnSigninFacebook_Click(_ sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // 呼叫 Firebase APIs 來執行登入
            Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                //fetch displayname add to firebase database
                let currentUser = Auth.auth().currentUser
                self.ref.child("users").child(currentUser!.uid).child("user").setValue(currentUser?.displayName)
                let profileImageUrl = currentUser?.photoURL?.absoluteString
                
                
                if currentUser != nil {
                    
                    let userRef = Database.database().reference()
                    userRef.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        if snapshot.hasChild("introduction") {
                            //do nothing
                        } else {
                            self.ref.child("users").child(currentUser!.uid).child("introduction").setValue(" ")
                        }
                        
                        if snapshot.hasChild("photoUrl") {
                            
                        } else {
                            self.ref.child("users").child(currentUser!.uid).child("photoUrl").setValue(profileImageUrl)
                        }
                        
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                }
                

                // 呈現主視圖
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
        }
    }
    
    @IBAction func btnSigninGoogle_Click(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self

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

    
    
    
    
    
    
}//end welcomeViewController

//要採用這兩個協定，它需要實作兩個方法來處理登入與登出的程序：
//
//func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
//
//func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
//第一個方法在登入程序完成會被呼叫，而接著的方法在使用者與 App 斷線時會被調用。

extension WelcomeViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            return
        }
        
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            
            //fetch displayname add to firebase database
            let currentUser = Auth.auth().currentUser
            self.ref.child("users").child(currentUser!.uid).child("user").setValue(currentUser?.displayName)
            let profileImageUrl = currentUser?.photoURL?.absoluteString
            self.ref.child("users").child(currentUser!.uid).child("photoUrl").setValue(profileImageUrl)
            if currentUser != nil {
                
                
                let userRef = Database.database().reference()
                userRef.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.hasChild("introduction") {
                        //do nothing
                    } else {
                        self.ref.child("users").child(currentUser!.uid).child("introduction").setValue(" ")
                    }

                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }

            // 呈現主視圖
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}







