//
//  ChatRoomViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController {
    
    @IBAction func btnChat_Click(_ sender: Any) {
        let myChatsTest: UsersCollectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatCollectionView") as! UsersCollectionViewController
        if let navagator = navigationController {
            myChatsTest.hidesBottomBarWhenPushed = true
            navagator.pushViewController(myChatsTest, animated: true)
            
            //self.navigationController?.show(myChatsTest, sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "灰色漸層")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            self.showMessage(messageToDisplay: "要使用此功能請先註冊會員")
            return
        }
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

}
