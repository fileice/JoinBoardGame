//
//  GroupDetailViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/3.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import JSQMessagesViewController
import CoreLocation

class GroupDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    
    @IBOutlet weak var groupTableView: UITableView!
    
    
    var groupSimpleList = [Group_Simple]()
  
    var cityName: String = ""
    var gameClassType: String = ""
    var gameName: String = ""
    var groupEndTime: String = ""
    var groupMax: String = ""
    var groupMin: String = ""
    var groupName: String = ""
    var groupStartTime: String = ""
    var shopName: String = ""
    var userName: String = ""
    var userId: String = ""
    var userPhotoUrl: String = ""
    
    var address: String = ""
    var map_longitude: String = ""
    var map_latitude: String = ""
    var shopTel: String = ""
    var opentime: String = ""
    var closetime: String = ""

    var groupAllList = [Group_All]()
    var groupAllArray: [String] = []

    //定位宣告
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupAllArray.append(groupName)
        self.groupAllArray.append(userName)
        self.groupAllArray.append(gameClassType)
        self.groupAllArray.append(gameName)
        self.groupAllArray.append(groupStartTime)
        self.groupAllArray.append(groupEndTime)
        self.groupAllArray.append(groupMax)
        self.groupAllArray.append(groupMin)
        self.groupAllArray.append(shopName)
        //self.groupAllArray.append(userId)
        
        
        self.groupAllArray.append(address)
        //self.groupAllArray.append(map_longitude)
        //self.groupAllArray.append(map_latitude)
        //self.groupAllArray.append(cityName)
        
        //print(self.userId)
        
        self.groupTableView.delegate = self
        self.groupTableView.dataSource = self
        self.hidesBottomBarWhenPushed = true
        loadMembers()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //第二頁不顯示tabbar
        self.hidesBottomBarWhenPushed = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /********* start groupTableView protocol *************/
    var memberArray = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowNum: Int = 0
        if section == 0 {
            return groupAllArray.count + 2 //自訂欄位
        } else if section == 1 {
            return memberNameArray.count
        }
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        if indexPath.section == 0 {
            
            //print(self.memberList)
            //cell.accessoryType = .detailButton
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "團名：\(groupAllArray[indexPath.row])"
                cell.accessoryType = .detailButton
            case 1:
                cell.textLabel?.text = "團長：\(groupAllArray[indexPath.row])"
            case 2:
                cell.textLabel?.text = "遊戲類型：\(groupAllArray[indexPath.row])"
            case 3:
                cell.textLabel?.text = "遊戲名稱：\(groupAllArray[indexPath.row])"
            case 4:
                cell.textLabel?.text = "開團時間：\(groupAllArray[indexPath.row])"
            case 5:
                cell.textLabel?.text = "結束時間：\(groupAllArray[indexPath.row])"
            case 6:
                cell.textLabel?.text = "最大人數：\(groupAllArray[indexPath.row])"
            case 7:
                cell.textLabel?.text = "最小人數：\(groupAllArray[indexPath.row])"
            case 8:
                cell.textLabel?.text = "店家名稱：\(groupAllArray[indexPath.row])"
            case 9:
                cell.textLabel?.text = "店家地址：\(groupAllArray[indexPath.row])"
                cell.accessoryType = .detailButton
            case 10:
                cell.textLabel?.text = "進入群組聊天"
                cell.accessoryType = .detailButton
            case 11: //判斷使用者顯示不同資訊
                if currentuser?.uid == self.userId {
                    cell.textLabel?.text = "↓↓↓↓↓ 團長 =====>"
                    cell.accessoryType = .detailButton
                } else {
                    cell.textLabel?.text = "↓↓↓↓↓ 成員 ↓↓↓↓↓"
                    cell.accessoryType = .checkmark
                }
            default:
                break
            }
            
        } else if indexPath.section == 1 {

            if currentuser?.uid == self.userId {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.textLabel?.text = memberNameArray[indexPath.row]
           
        }
        
        
//        if indexPath.row == 0 {
//            cell.textLabel?.text = "縣市：\(groupAllArray[indexPath.row])"
//        }
//        cell.textLabel?.text = groupAllArray[indexPath.row]
        
        return cell
    }
    
    let currentuser = Auth.auth().currentUser
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //判斷是否為團長,團長才有權限更改團名
                if currentuser?.uid == self.userId{
                    let myVCUserModify: ModifyUserInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcModifyUserInfo") as! ModifyUserInfoViewController
                    myVCUserModify.strMsg = self.groupName
                    myVCUserModify.strTitle = "團名修改"
                    self.navigationController?.show(myVCUserModify, sender: nil)
                } else {
                    let alertController = UIAlertController(title: "提示",message: "只有團長能修改資料",preferredStyle: .alert)
                    
                    // 建立[確認]按鈕
                    let okAction = UIAlertAction(title: "返回", style: UIAlertActionStyle.default, handler: nil)
                    alertController.addAction(okAction)
                    
                    // 顯示提示框
                    self.present(alertController,animated: true,completion: nil)
                }
                
            } else if indexPath.row == 9 {
                //判斷是否有開啟定位,如果沒有跳出警告,要使用者開啟,若無判斷,使用者關閉定位,會造成app閃退
                let status = CLLocationManager.authorizationStatus()
                
                if status == .notDetermined {
                    locationManager.requestWhenInUseAuthorization()
                    return
                }
                
                if status == .denied || status == .restricted {
                    let alert = UIAlertController(title: "請開啟定位服務", message: "定位服務未開啟,請進入系統設置>隱私>定位服務中打開開關,並允許使用定位服務", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                    return
                } else {
                    let mapViewVC: MapKitViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapKitViewController
                    
                    mapViewVC.map_latitude = self.map_latitude
                    mapViewVC.map_longitude = self.map_longitude
                    mapViewVC.address = self.address
                    mapViewVC.shopName = self.shopName
                    mapViewVC.startTime = self.groupStartTime
                    mapViewVC.endTime = self.groupEndTime
                    mapViewVC.shopTel = self.shopTel
                    mapViewVC.opentime = self.opentime
                    mapViewVC.closetime = self.closetime
                    self.navigationController?.show(mapViewVC, sender: nil)
                }
                
                
            } else if indexPath.row == 10 {
                //判斷是否有參加團體,有參加才能進入群組聊天
                if currentuser?.uid == self.userId {
                    let myChatsVC: GroupChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "GroupChatVC") as! GroupChatViewController
                    
                    myChatsVC.userPhouoUrl = self.userPhotoUrl
                    myChatsVC.otherUserArray = memberNameArray
                    myChatsVC.chatName = "\(self.groupName)" + "(\(memberNameArray.count))"
                    //myChatsVC.otherPhotoArray = memberPhotoUrlArray
                    myChatsVC.groupId = self.userId
                    
                    if let navigator = navigationController {
                        myChatsVC.hidesBottomBarWhenPushed = true
                        navigator.pushViewController(myChatsVC, animated: true)
                    }
                } else {
                    let currentUser = Auth.auth().currentUser
                    let userInGroupBool: Bool = false
                    if userInGroupBool != self.useridArray.contains((currentUser?.uid)!) {
                        
                        let myChatsVC: GroupChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "GroupChatVC") as! GroupChatViewController
                        
                        myChatsVC.userPhouoUrl = self.userPhotoUrl
                        myChatsVC.otherUserArray = memberNameArray
                        myChatsVC.chatName = "\(self.groupName)" + "(\(memberNameArray.count))"
                        //myChatsVC.otherPhotoArray = memberPhotoUrlArray
                        myChatsVC.groupId = self.userId
                        
                        if let navigator = navigationController {
                            myChatsVC.hidesBottomBarWhenPushed = true
                            navigator.pushViewController(myChatsVC, animated: true)
                        }
                        
                    } else {
                        let alertController = UIAlertController(title: "群組訊息", message: "加入團體才能使用聊天功能", preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: nil)
                     
                        alertController.addAction(cancelAction)
                        self.present(alertController,animated: true,completion: nil)
                    }
                }
            } else if indexPath.row == 11 {
                
                //團長介面
                if currentuser?.uid == self.userId{
                    let alertController = UIAlertController(title: "團長介面",message: "請確認是否要取消開團？",preferredStyle: .alert)
                    
                    // 建立[確認]按鈕
                    let okAction = UIAlertAction(title: "確認取消", style: UIAlertActionStyle.default) { (deleteGroup) in
                        let group_simpleRef = Constants.UploadToGroup_simple.databaseGropus.child(self.userId)
                        group_simpleRef.removeValue()
                        let groupsRef = Constants.UploadToGroups.databaseGropus.child(self.userId)
                        groupsRef.removeValue()
                        
                        let groupChatRef = Constants.GroupChat_Ref.databaseGroupChat.child("\(self.userId)")
                        groupChatRef.removeValue()
                        
                        
                        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                            UIApplication.shared.keyWindow?.rootViewController = viewController
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    let cancelAction = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    // 顯示提示框
                    self.present(alertController,animated: true,completion: nil)
                } else {
                    //使用者介面
                    let currentUser = Auth.auth().currentUser
                    let userInGroupBool: Bool = false
                    if userInGroupBool == self.useridArray.contains((currentUser?.uid)!) {
                        
                        //判斷人數是否達團長設定上限
                        var count: Int = 0
                        count = Int(self.groupMax)!
                        
                        if self.memberArray.count >= count {
                            let alertController = UIAlertController(title: "人數已滿", message: "此團人數已達上限", preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        } else {
                            
                            let alertController = UIAlertController(title: "使用者介面",message: "是否要參加此團體",preferredStyle: .alert)
                            // 建立[確認]按鈕 ,寫入firebase
                            let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default) { (joinGroup) in
                                let group_simpleRef = Constants.UploadToGroup_simple.databaseGropus
                                let strMsg = ["name":currentUser?.displayName ?? "", "userPhotoUrl":currentUser?.photoURL?.absoluteString as Any] as [String : Any]
                                group_simpleRef.child(self.userId).child("members").child((currentUser?.uid)!).setValue(strMsg)
                                
                            }
                            alertController.addAction(okAction)
                            
                            let cancelAction = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: nil)
                            alertController.addAction(cancelAction)
                            
                            // 顯示提示框
                            self.present(alertController,animated: true,completion: nil)
                            
                        }//end memberArray.count
                        
                    } else {
                        
                        let alertController = UIAlertController(title: "使用者介面",message: "是否要退出團體",preferredStyle: .alert)
                        // 建立[確認]按鈕
                        let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default) { (joinGroup) in
                            let group_simpleRef = Constants.UploadToGroup_simple.databaseGropus
                            group_simpleRef.child(self.userId).child("members").child((currentUser?.uid)!).removeValue()
                        }
                        alertController.addAction(okAction)
                        
                        let cancelAction = UIAlertAction(title: "返回", style: UIAlertActionStyle.cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        
                        // 顯示提示框
                        self.present(alertController,animated: true,completion: nil)
                    }
                }
            } else if indexPath.section == 1 {
                //do nothing...
            }
            
        }//end indexpath.section
    }//end tableview didSelectRowAt
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //判斷是否是團長,團長可以操作刪除
        if currentuser?.uid == self.userId {
            return true //全部都可以操作
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //tableview 向右滑 刪除成員選項
        if editingStyle == UITableViewCellEditingStyle.delete {
            if indexPath.section == 0 {
                //do nothing
            }else if indexPath.section == 1 {
                //print(useridArray[indexPath.row])
               
                if self.userId == useridArray[indexPath.row] {
                    
                } else {
                    let deleteRef = Constants.UploadToGroup_simple.databaseGropus
                    deleteRef.child(self.userId).child("members").child(useridArray[indexPath.row]).removeValue()
                }
            }
            tableView.reloadData()
        }
    }
    
    
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        var strTitle: String = ""
//        if section == 0 {
//            strTitle = "開團資訊"
//        } else if section == 1 {
//            strTitle = "成員"
//        }
//        return strTitle
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var strTitle: String = ""
        if section == 0 {
            strTitle = "開團資訊"
        } else if section == 1 {
            strTitle = ""
        }
        return strTitle
    }
    
    
    /********* end groupTableView protocol *************/
    
    var memberList = [Members]()
    var useridArray = [String]()
    var memberNameArray = [String]()
    var memberPhotoUrlArray = [String]()
    var memberDict = [String: Any]()
    
    func loadMembers() {
        //讀取成員
        let userRef = Database.database().reference()
        
        userRef.child("group_simple").child(self.userId).child("members").observe(.childAdded, with: { (snapshot) in
            //print(snapshot)
            if let mygroupDict = snapshot.value as? [String:AnyObject] {
                //print("\(mygroupDict)======")
//                for(userid, value) in mygroupDict {
//                    let groupdict = value as? [String: Any]
//                    var memberInfo = Members()
//
//                    memberInfo.name = groupdict!["name"] as? String
//                    memberInfo.userPhotoUrl = groupdict!["userPhotoUrl"] as? String
//                    self.memberList.append(memberInfo)
//                    self.useridArray.append(userid)
//                    //print(self.useridArray)
//
//                    self.groupTableView.reloadData()
//                }
            
                
   
                
                if let idArr = snapshot.key as? String {
                        self.useridArray.append(idArr)
                        self.groupTableView.reloadData()
                    }

                if let testDict = snapshot.value as? [String: Any] {
                    let aaa = testDict["name"] as? String
                    self.memberNameArray.append(aaa!)

                    if testDict["userPhotoUrl"] as? String != nil {
                        let bbb = testDict["userPhotoUrl"] as? String
                        self.memberPhotoUrlArray.append(bbb!)
                    }


                    self.groupTableView.reloadData()
                }
        
            }
        }) { (error) in
            print(error.localizedDescription)
        }


        
    }//end loadMembers
}//end GroupDetailViewController



















