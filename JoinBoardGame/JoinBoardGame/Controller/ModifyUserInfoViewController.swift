//
//  ModifyUserInfoViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/17.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ModifyUserInfoViewController: UIViewController,UITextFieldDelegate {
    
    var strMsg: String = ""
    var strTitle: String = ""
    var ref: DatabaseReference!
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    
    @IBOutlet weak var modifyTextField: UITextField!
    
    @IBAction func modifyTextField_EndEdit(_ sender: Any) {
        //press return to endedit
    }
    
    
    @IBAction func btnSave_click(_ sender: Any) {
        if strTitle == "姓名" {
            let currentUser = Auth.auth().currentUser
            self.ref.child("users").child(currentUser!.uid).updateChildValues(["user" : modifyTextField.text as Any])
        } else if strTitle == "自我介紹" {
            let currentUser = Auth.auth().currentUser
            self.ref.child("users").child(currentUser!.uid).updateChildValues(["introduction" : modifyTextField.text as Any])
        } else if strTitle == "團名修改" {
            let currentUser = Auth.auth().currentUser
            self.ref.child("group_simple").child(currentUser!.uid).updateChildValues(["groupName" : modifyTextField.text as Any])
        }
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modifyTextField.delegate = self
        ref = Database.database().reference()
        self.modifyTextField.text = self.strMsg
        self.title = self.strTitle
        
        if strTitle == "姓名" {
            lblCount.text = "\(String(describing: modifyTextField.text!.count))"
            lblMax.text = "/20"
        } else if strTitle == "自我介紹" {
            lblCount.text = "\(String(describing: modifyTextField.text!.count))"
            lblMax.text = "/500"
        } else if strTitle == "團名修改" {
            lblCount.text = "\(String(describing: modifyTextField.text!.count))"
            lblMax.text = "/20"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //textFiled delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if strTitle == "姓名" {
            let countOfWords = string.count +  modifyTextField.text!.count - range.length
            if countOfWords > 20{
                return false
            }
            lblCount.text = String(countOfWords)
        } else if strTitle == "自我介紹" {
            let countOfWords = string.count +  modifyTextField.text!.count - range.length
            if countOfWords > 500{
                return false
            }
            
            lblCount.text = String(countOfWords)
        }
        
        return true
        
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
