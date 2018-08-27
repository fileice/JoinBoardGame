//
//  GroupStartedViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class GroupStartedViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    
    //******************建立事件*******************//
    //團名
    @IBOutlet weak var btnGroupname: UIButton!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    //遊戲選擇 pickerView tag = 0
    @IBAction func btnGameChooseSelected(_ sender: Any) {
        //用for loop 讓隱藏按鈕出現
        for option in gameChooseOption {
            //加上動畫
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if gameChoosePickerView.isHidden == false {
            locationChoosePickerView.isHidden = true
            startTimePicker.isHidden = true
            endTimeDetePicker.isHidden = true
            maxStepper.isHidden = true
            minStepper.isHidden = true
            shopPickerView.isHidden = true
        }
    }
    @IBOutlet weak var gameChooseTextField: UITextField!
    @IBOutlet var gameChooseOption: [UIPickerView]!
    @IBOutlet weak var gameChoosePickerView: UIPickerView!
    
    //地點選擇 pickerView tag = 1
    @IBAction func btnLocationSelected(_ sender: Any) {
        //用for loop 讓隱藏按鈕出現
        for option in locationChooseOption {
            //加上動畫
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if locationChoosePickerView.isHidden == false {
            gameChoosePickerView.isHidden = true
            startTimePicker.isHidden = true
            endTimeDetePicker.isHidden = true
            maxStepper.isHidden = true
            minStepper.isHidden = true
            shopPickerView.isHidden = true
        }
    }
    @IBOutlet weak var locationChooseTextField: UITextField!
    @IBOutlet var locationChooseOption: [UIPickerView]!
    @IBOutlet weak var locationChoosePickerView: UIPickerView!
    
    //選擇店家
    @IBAction func shopSelected(_ sender: Any) {
        for option in shopOption {
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if shopPickerView.isHidden == false {
            locationChoosePickerView.isHidden = true
            gameChoosePickerView.isHidden = true
            startTimePicker.isHidden = true
            endTimeDetePicker.isHidden = true
            maxStepper.isHidden = true
            minStepper.isHidden = true
        }
    }
    @IBOutlet var shopOption: [UIPickerView]!
    @IBOutlet weak var shopPickerView: UIPickerView!
    @IBOutlet weak var shopChooseTextField: UITextField!

    //活動開始時間  starttime
    @IBAction func startTimeSelected(_ sender: Any) {
        for option in startTimeOption {
            //加上動畫
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if startTimePicker.isHidden == false {
            gameChoosePickerView.isHidden = true
            locationChoosePickerView.isHidden = true
            endTimeDetePicker.isHidden = true
            maxStepper.isHidden = true
            minStepper.isHidden = true
            shopPickerView.isHidden = true
        }
    }
    @IBOutlet var startTimeOption: [UIDatePicker]!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var gameSartTimeTextFiled: UITextField!
    
    //活動結束時間
    @IBAction func endTimeSelected(_ sender: Any) {
        for option in endTimeOption {
            //加上動畫
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if endTimeDetePicker.isHidden == false {
            gameChoosePickerView.isHidden = true
            locationChoosePickerView.isHidden = true
            startTimePicker.isHidden = true
            maxStepper.isHidden = true
            minStepper.isHidden = true
            shopPickerView.isHidden = true
        }
    }
    @IBOutlet weak var endTimeTextFiled: UITextField!
    @IBOutlet var endTimeOption: [UIDatePicker]!
    @IBOutlet weak var endTimeDetePicker: UIDatePicker!
    
    //最大需求人數
    @IBAction func btnMaxSelected(_ sender: Any) {
        for option in maxStepperOption {
            //加上動畫
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if maxStepper.isHidden == false {
            gameChoosePickerView.isHidden = true
            locationChoosePickerView.isHidden = true
            startTimePicker.isHidden = true
            endTimeDetePicker.isHidden = true
            minStepper.isHidden = true
            shopPickerView.isHidden = true
        }
    }
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet var maxStepperOption: [UIStepper]!
    @IBOutlet weak var maxStepper: UIStepper!
    @IBAction func maxStepper_ValueChange(_ sender: Any) {
        let stepperValue: Double = maxStepper.value
        maxTextField.text = "最大人數:\(Int(stepperValue))"
        groupMax = "\(Int(stepperValue))"
    }
    
    //最小需求人數
    @IBAction func bntMinSelected(_ sender: Any) {
        for option in minStepperOption {
            //加上動畫
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                //讓動畫從自己的view出現
                self.view.layoutIfNeeded()
            }
        }
        if minStepper.isHidden == false {
            gameChoosePickerView.isHidden = true
            locationChoosePickerView.isHidden = true
            startTimePicker.isHidden = true
            endTimeDetePicker.isHidden = true
            maxStepper.isHidden = true
            shopPickerView.isHidden = true
        }
    }
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var minStepper: UIStepper!
    @IBOutlet var minStepperOption: [UIStepper]!
    
    @IBAction func minStepper_ValueChanged(_ sender: Any) {
        if minStepper.value > maxStepper.value {
            let stepperValue: Double = maxStepper.value
            minTextField.text = "最小人數:\(Int(stepperValue))"
            groupMin = "\(Int(stepperValue))"
        } else {
            let stepperValue: Double = minStepper.value
            minTextField.text = "最小人數:\(Int(stepperValue))"
            groupMin = "\(Int(stepperValue))"
        }
    }
    
    //存入firebase DB
    var areaName: String = ""
    var cityName: String = ""
    var groupStartTime: String = ""
    var groupEndTime: String = ""
    var gameName: String = ""
    var groupName: String = ""
    var groupMax: String = ""
    var groupMin: String = ""
    var gameMember: String = ""
    var shopName: String = ""
    var getuserName: String = ""
    var map_latitude: String = ""
    var map_longtitude: String = ""
    var shopAddress: String = ""
    var gameClassType: String = ""
    var shopTel: String = ""
    var closeTime: String = ""
    var openTime: String = ""
    var phohoUrl: String = ""
    
    var userPhotoUrl: String = ""
    
    //btn
    @IBAction func btnStartGroup_Click(_ sender: Any) {
        
        if groupNameTextField.text?.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "團名請勿空白")
            return
        } else if self.gameClassType.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇遊戲類型")
            return
        } else if self.gameName.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇遊戲名稱")
            return
        } else if self.areaName.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇地區")
            return
        } else if self.shopName.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇店家")
            return
        } else if self.groupStartTime.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇遊戲時間")
            return
        } else if self.groupEndTime.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇結束時間")
            return
        } else if self.groupMax.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇遊戲人數")
            return
        } else if self.groupMin.isEmpty == true {
            self.showGroupMessage(messageToDisplay: "請選擇最小遊戲人數")
            return
        }
        
        
        groupName = groupNameTextField.text!
        
        let alertUpload = UIAlertController(title: "開團", message: "您確定要開團嗎", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: { (Void) in
//            print(self.groupStartTime)
//            print(self.groupEndTime)
//            print(self.groupName)
//            print(self.groupMax)
//            print(self.groupMin)
//            print(self.gameClassType)
//            print(self.gameName)
//            print(self.areaName)
//            print(self.shopName)
//            print(self.cityName)
//            print(self.getuserName)
//            //groups
//            print(self.map_longtitude)
//            print(self.map_latitude)
//            print(self.shopAddress)
           
            //寫入firebase DB
            let currentUser = Auth.auth().currentUser
            
            let groupsSimpleRef = Constants.UploadToGroup_simple.databaseGropus.child(currentUser!.uid)
            let strMsg = ["groupStartTime":self.groupStartTime, "groupEndTime":self.groupEndTime, "groupName":self.groupName, "groupMax":self.groupMax, "groupMin":self.groupMin, "gameClassType":self.gameClassType, "gameName":self.gameName, "shopName":self.shopName, "cityName":self.cityName, "userName":self.getuserName,"photoUrl": self.phohoUrl, "userPhotoUrl": self.userPhotoUrl]
            groupsSimpleRef.setValue(strMsg)
            
            let groupsRef = Constants.UploadToGroups.databaseGropus.child(currentUser!.uid)
            let strMsg1 = ["map_longtitude":self.map_longtitude, "map_latitude":self.map_latitude, "shopAddress":self.shopAddress, "shopTel": self.shopTel, "closetime":self.closeTime, "opentime":self.openTime]
            groupsRef.setValue(strMsg1)

            
            let membersRef = Constants.UploadToGroup_simple.databaseGropus.child((currentUser!.uid)).child("members").child((currentUser!.uid))
            let strMsg2 = ["name": currentUser?.displayName]
            membersRef.setValue(strMsg2)
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
           
            })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertUpload.addAction(alertAction)
        alertUpload.addAction(cancelAction)
        
        self.present(alertUpload, animated: true, completion: nil)
        
    }
    
    
    public func showGroupMessage(messageToDisplay: String){
        
        let alertController = UIAlertController(title: "欄位空白", message: messageToDisplay, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //取消清空欄位
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.groupNameTextField.text = ""
        self.gameChooseTextField.text = ""
        self.locationChooseTextField.text = ""
        self.shopChooseTextField.text = ""
        self.maxTextField.text = ""
        self.minTextField.text = ""
        self.gameSartTimeTextFiled.text = ""
        self.endTimeTextFiled.text = ""
    }
    
    //****************** end 建立事件 *******************//
    
    //時間處理
    var startTimeString: String = ""
    var endTimeString: String = ""
    var dateTimeNow: String = ""
    let dateFormatter: DateFormatter = DateFormatter()
    var startTime: Date = Date()

    @IBAction func startTimePicker_ValueChanged(_ sender: Any) {
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let dateNow: Date = Date()
        dateTimeNow = dateFormatter.string(from: dateNow)
        
        // 可以選擇的最早日期時間
        let fromDateTime = dateFormatter.date(from: dateTimeNow)
        
        // 設置可以選擇的最早日期時間
        startTimePicker.minimumDate = fromDateTime
        
        //set gameStartTime
        let mySelectTime: Date = self.startTimePicker.date
        startTimeString = dateFormatter.string(from: mySelectTime)
        gameSartTimeTextFiled.text = startTimeString
        startTime = mySelectTime
        groupStartTime = startTimeString
    }
    
    @IBAction func endTimePicker_ValueChanged(_ sender: Any) {
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        //set endTimePicker
        let mySelectTime: Date = self.endTimeDetePicker.date
        endTimeString = dateFormatter.string(from: mySelectTime)
        
        //設定結束時間無法比開始時間早
        endTimeDetePicker.minimumDate = startTime
        endTimeTextFiled.text = endTimeString
        groupEndTime = endTimeString
    }
    
    //set pickerView Delegate & datasource
    func setPickerViewPotocol() {
        //gamechoose tag = 0
        self.gameChoosePickerView.delegate = self
        self.gameChoosePickerView.dataSource = self
        
        //location tag = 1
        self.locationChoosePickerView.delegate = self
        self.locationChoosePickerView.dataSource = self
        
        //shop tag = 2
        self.shopPickerView.delegate = self
        self.shopPickerView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setPickerViewPotocol()
        //設置datepicker語言
        startTimePicker.locale = NSLocale(localeIdentifier: "zh_TW") as Locale
        endTimeDetePicker.locale = NSLocale(localeIdentifier: "zh_TW") as Locale
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateNow: Date = Date()
        dateTimeNow = dateFormatter.string(from: dateNow)
        // 可以選擇的最早日期時間
        let fromDateTime = dateFormatter.date(from: dateTimeNow)
        let strPlaceholderTime = dateFormatter.string(from: fromDateTime!)
        
        gameSartTimeTextFiled.placeholder = strPlaceholderTime
        endTimeTextFiled.placeholder = strPlaceholderTime
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadData()
        getUserName()
        
        super.viewWillAppear(true)
        let currentUser = Auth.auth().currentUser
        
        if currentUser == nil {
            self.showMessage(messageToDisplay: "要使用此功能請先註冊會員")
            return
        }
    }
    
    public func showMessage(messageToDisplay: String){
        
        let alertController = UIAlertController(title: "請先註冊會員", message: messageToDisplay, preferredStyle: .alert)
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
    
    func getUserName() {
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let userRef = Database.database().reference()
            userRef.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myuserDict = snapshot.value as? [String:AnyObject] {
                    let newuser = UserInfo()
                    newuser.user = myuserDict["user"] as? String
                    self.getuserName = (myuserDict["user"] as? String)!
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    

    func isHiddenControl() {
        switch false {
        case gameChoosePickerView.isHidden:
            gameChoosePickerView.isHidden = true
        case locationChoosePickerView.isHidden:
            locationChoosePickerView.isHidden = true
        case startTimePicker.isHidden:
            startTimePicker.isHidden = true
        case endTimeDetePicker.isHidden:
            endTimeDetePicker.isHidden = true
        case maxStepper.isHidden:
            maxStepper.isHidden = true
        case minStepper.isHidden:
            minStepper.isHidden = true
        case shopPickerView.isHidden:
            shopPickerView.isHidden = true
        default:
            break
        }
    }
    
    
    @IBAction func groupNameTextField_EndEdit(_ sender: Any) {
        //打完按return 收鍵盤
    }
    
    //觸控空白處收鍵盤,一次實做四種狀態,不一定要程式碼
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //觸控瞬間
        groupNameTextField.resignFirstResponder()
        isHiddenControl()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //手指離開
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //滑動瞬間
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //中斷
    }
    //******** ebd textfield delegate potocol **************//
    
    //******** start pickerView delegate potocol **************//
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        var componentsNum: Int = 0
        if pickerView.tag == 0 {
            componentsNum = 2
        } else if pickerView.tag == 1 {
            componentsNum = 2
        } else if pickerView.tag == 2 {
            componentsNum = 1
        }
        return componentsNum
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var intRowNum: Int = 0
        
        if pickerView.tag == 0 {
            if component == 0 {
               intRowNum = classKeyArray.count
            } else if component == 1 {
                intRowNum = gamestructList.count
            }
        } else if pickerView.tag == 1 {
            if component == 0 {
                intRowNum = 1//cityNameArray.count
            } else if component == 1 {
                intRowNum = areaNameArray.count
            }
        } else if pickerView.tag == 2 {
            intRowNum = areaNameArrayAll.count
        }
        return intRowNum
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //決定滾輪內容
        var StrRow: String = ""
        
        if pickerView.tag == 0 {
            if component == 0 {
                StrRow = classKeyArray[row]
            } else if component == 1 {
                StrRow = gamestructList[row].tg_name!
            }
        } else if pickerView.tag == 1 {
            if component == 0 {
                StrRow = "高雄市"//cityNameArray[row]
            } else if component == 1 {
                StrRow = areaNameArray[row]
            }
        } else if pickerView.tag == 2 {
            StrRow = areaNameArrayAll[row]
        }
        return StrRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //var strMsg: String = ""
        
        if pickerView.tag == 0 {
            if component == 0 {
                Dynamicloading(classKeyArray[row])
                gameClassType = classKeyArray[row]
            } else if component == 1 {
                self.gameChooseTextField.text = gamestructList[row].tg_name!
                self.maxStepper.maximumValue = Double(gamestructList[row].tg_max!)
                self.minStepper.minimumValue = Double(gamestructList[row].tg_min!)
                self.phohoUrl = gamestructList[row].photoUrl!
                gameName = gamestructList[row].tg_name!
                //print(gamestructList[row].photoUrl!)
                //print(gamestructList[row].tg_name!)
            }
        } else if pickerView.tag == 1 {
            if component == 0 {
            
            } else if component == 1 {
                Dynamicloading2(areaNameArray[row])
                self.locationChooseTextField.text = "高雄市 \(areaNameArray[row])"
                areaName = areaNameArray[row]
                cityName = "高雄市"//cityNameArray[row]
            }
        } else if pickerView.tag == 2 {
            self.shopChooseTextField.text = areaNameArrayAll[row]
            shopName = areaNameArrayAll[row]
            //print(areaNameListAll[row].title)
            shopAddress = areaNameListAll[row].address!
            map_longtitude = areaNameListAll[row].map_longitude!
            map_latitude = areaNameListAll[row].map_latitude!
            shopTel = areaNameListAll[row].tel!
            closeTime = areaNameListAll[row].closetime!
            openTime = areaNameListAll[row].opentime!
        }
    }
    
    func Dynamicloading(_ strQuery: String){
        
        if strQuery == "兒童親子" {
            gamestructList.removeAll()
            gamestructList = gamestructListOne
            self.gameChoosePickerView.reloadComponent(1)
        } else if strQuery == "家庭聚會" {
            gamestructList.removeAll()
            gamestructList = gamestructListTwo
            self.gameChoosePickerView.reloadAllComponents()
        } else if strQuery == "派對聯誼" {
            gamestructList.removeAll()
            gamestructList = gamestructListThree
            self.gameChoosePickerView.reloadAllComponents()
        }  else if strQuery == "情境冒險" {
            gamestructList.removeAll()
            gamestructList = gamestructListFour
            self.gameChoosePickerView.reloadAllComponents()
        }
    }
    
    func Dynamicloading2(_ strQuery: String){
        if strQuery == "三民區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArrayOne {
                areaNameArrayAll.append(aaa)
            }
            self.locationChoosePickerView.reloadAllComponents()
            self.shopPickerView.reloadComponent(0)
        } else if strQuery == "前鎮區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArrayTwo {
                areaNameArrayAll.append(aaa)
            }
            self.shopPickerView.reloadAllComponents()
        } else if strQuery == "左營區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArrayThree {
                areaNameArrayAll.append(aaa)
            }
            self.shopPickerView.reloadAllComponents()
        } else if strQuery == "新興區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArrayFour {
                areaNameArrayAll.append(aaa)
            }
            self.shopPickerView.reloadAllComponents()
        } else if strQuery == "苓雅區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArrayFive {
                areaNameArrayAll.append(aaa)
            }
            self.shopPickerView.reloadAllComponents()
        } else if strQuery == "鳳山區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArraySix {
                areaNameArrayAll.append(aaa)
            }
            self.shopPickerView.reloadAllComponents()
        } else if strQuery == "鼓山區" {
            areaNameArrayAll.removeAll()
            for aaa in areaNameArraySeven {
                areaNameArrayAll.append(aaa)
            }
            self.shopPickerView.reloadAllComponents()
        }
    }
    
    
    
    //******** end pickerView delegate potocol **************/
    
    var classKeyArray = [String]()
//    var gameNameArrayOne = [String]()
//    var gameNameArrayTwo = [String]()
//    var gameNameArrayThree = [String]()
//    var gameNameArrayAll = [String]()
    var cityNameArray = [String]()
    var areaNameArray = [String]()
    
    var areaNameArrayAll = [String]()
    var areaNameArrayOne = [String]()
    var areaNameArrayTwo = [String]()
    var areaNameArrayThree = [String]()
    var areaNameArrayFour = [String]()
    var areaNameArrayFive = [String]()
    var areaNameArraySix = [String]()
    var areaNameArraySeven = [String]()
    
    
    var shopinfoList = [ShopInfo]()
    var areaNameListAll = [ShopInfo]()
    var areaNameListOne = [ShopInfo]()
    var areaNameListTow = [ShopInfo]()
    var areaNameListThree = [ShopInfo]()
    var areaNameListFour = [ShopInfo]()
    var areaNameListFive = [ShopInfo]()
    var areaNameListSix = [ShopInfo]()
    var areaNameListSeven = [ShopInfo]()
    
    var gamenameList = [GameName]()
    var gamestructList = [GameStruct]()
    
    var gamestructListOne = [GameStruct]()
    var gamestructListTwo = [GameStruct]()
    var gamestructListThree = [GameStruct]()
    var gamestructListFour = [GameStruct]()
    
    //var gameclassList = GameClass.self
    
    
    var nameArray = [String]()
    var emptyDict: [String: AnyObject] = [:]
    
    func loadData() {
        self.classKeyArray.removeAll()
//        self.gameNameArrayOne.removeAll()
//        self.gameNameArrayTwo.removeAll()
//        self.gameNameArrayThree.removeAll()
        self.cityNameArray.removeAll()
        self.areaNameArray.removeAll()
        self.areaNameListAll.removeAll()
        self.areaNameListOne.removeAll()
        self.areaNameListTow.removeAll()
        self.areaNameListThree.removeAll()
        self.areaNameListFour.removeAll()
        self.areaNameListFive.removeAll()
        self.areaNameListSix.removeAll()
        self.areaNameListSeven.removeAll()
        

        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let userRef = Database.database().reference()
            userRef.child("game_Introduction").child("class").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myuserDict = snapshot.value as? [String:AnyObject] {
                    //print(myuserDict)
                
                    //class name array
                    for classKey in myuserDict.keys {
                        self.classKeyArray.append(classKey)
                    }
                    //print(self.classKeyArray)
                    
                    
                    for item in snapshot.children.allObjects as! [DataSnapshot] {
                        let gameInfo = item.value as? [String: Any] ?? [:]
                        
                        for (_,value) in gameInfo {
                            let gamedict = value as? [String: Any]
                            //print(gamedict!["tg_max"])
                            var gamestruct = GameStruct()
                            gamestruct.tg_max = gamedict!["tg_max"] as? Int
                            gamestruct.tg_min = gamedict!["tg_min"] as? Int
                            gamestruct.tg_name = gamedict!["tg_name"] as? String
                            gamestruct.tg_introduction = gamedict!["tg_introduction"] as? String
                            gamestruct.photoUrl = gamedict!["photoUrl"] as? String
                            gamestruct.tg_class = gamedict!["tg_class"] as? String
                            
                            self.gamestructList.append(gamestruct)
                            //print(self.gamestructList)
                        }
                    }
                                        
//                    for (_,gameValus) in myuserDict as [String: Any] {
//                        let emptydict: [String: Any] = gameValus as! [String : Any]
//                        //print(emptydict)
//                        for aaa in emptydict.keys {
//                            self.gameNameArrayAll.append(aaa)
//                            //print(self.gameNameArrayAll)
//                        }

                       
//                        for item in snapshot.children.allObjects as! [DataSnapshot] {
//                            let gameInfo = item.value as? [String: Any] ?? [:]
//
//                            for (_,value) in gameInfo {
//                                let gamedict = value as? [String: Any]
//                                //print(gamedict!["tg_max"])
//                                var gamestruct = GameStruct()
//                                gamestruct.tg_max = gamedict!["tg_max"] as? Int
//                                gamestruct.tg_min = gamedict!["tg_min"] as? Int
//                                gamestruct.tg_name = gamedict!["tg_name"] as? String
//                                gamestruct.tg_introduction = gamedict!["tg_introduction"] as? String
//                                gamestruct.photoUrl = gamedict!["photoUrl"] as? String
//                                gamestruct.tg_class = gamedict!["tg_class"] as? String
//
//                                self.gamestructList.append(gamestruct)
//                                //print(self.gamestructList)
//                            }
//                        }
//                    }
                    self.gameChoosePickerView.reloadAllComponents()
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
            let nameRef = Database.database().reference()
            nameRef.child("game_Introduction").child("class").child("兒童親子").observeSingleEvent(of: .value, with: { (snapshot) in

                if let myuserDict = snapshot.value as? [String:AnyObject] {
//                    for gamename in myuserDict.keys {
//                        self.gameNameArrayOne.append(gamename)
//                    }
                    
                    for (_,value) in myuserDict {
                        let gamedict = value as? [String: Any]
                        //print(gamedict!["tg_max"])
                        var gamestruct = GameStruct()
                        gamestruct.tg_max = gamedict!["tg_max"] as? Int
                        gamestruct.tg_min = gamedict!["tg_min"] as? Int
                        gamestruct.tg_name = gamedict!["tg_name"] as? String
                        gamestruct.tg_introduction = gamedict!["tg_introduction"] as? String
                        gamestruct.photoUrl = gamedict!["photoUrl"] as? String
                        gamestruct.tg_class = gamedict!["tg_class"] as? String
                        
                        self.gamestructListOne.append(gamestruct)
                        //print(self.gamestructListOne)
                    }
                }
               
                self.gameChoosePickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("game_Introduction").child("class").child("家庭聚會").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myuserDict = snapshot.value as? [String:AnyObject] {
//                    for gamename in myuserDict.keys {
//                        self.gameNameArrayTwo.append(gamename)
//                    }
                    for (_,value) in myuserDict {
                        let gamedict = value as? [String: Any]
                        //print(gamedict!["tg_max"])
                        var gamestruct = GameStruct()
                        gamestruct.tg_max = gamedict!["tg_max"] as? Int
                        gamestruct.tg_min = gamedict!["tg_min"] as? Int
                        gamestruct.tg_name = gamedict!["tg_name"] as? String
                        gamestruct.tg_introduction = gamedict!["tg_introduction"] as? String
                        gamestruct.photoUrl = gamedict!["photoUrl"] as? String
                        gamestruct.tg_class = gamedict!["tg_class"] as? String
                        
                        self.gamestructListTwo.append(gamestruct)
                        //print(self.gamestructListTwo)
                    }
                }
                self.gameChoosePickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("game_Introduction").child("class").child("派對聯誼").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myuserDict = snapshot.value as? [String:AnyObject] {
//                    for gamename in myuserDict.keys {
//                        self.gameNameArrayThree.append(gamename)
//                    }
                    
                    for (_,value) in myuserDict {
                        let gamedict = value as? [String: Any]
                        //print(gamedict!["tg_max"])
                        var gamestruct = GameStruct()
                        gamestruct.tg_max = gamedict!["tg_max"] as? Int
                        gamestruct.tg_min = gamedict!["tg_min"] as? Int
                        gamestruct.tg_name = gamedict!["tg_name"] as? String
                        gamestruct.tg_introduction = gamedict!["tg_introduction"] as? String
                        gamestruct.photoUrl = gamedict!["photoUrl"] as? String
                        gamestruct.tg_class = gamedict!["tg_class"] as? String
                        
                        self.gamestructListThree.append(gamestruct)
                        //print(self.gamestructListThree)
                    }
                }
                self.gameChoosePickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("game_Introduction").child("class").child("情境冒險").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myuserDict = snapshot.value as? [String:AnyObject] {
                    //                    for gamename in myuserDict.keys {
                    //                        self.gameNameArrayTwo.append(gamename)
                    //                    }
                    for (_,value) in myuserDict {
                        let gamedict = value as? [String: Any]
                        //print(gamedict!["tg_max"])
                        var gamestruct = GameStruct()
                        gamestruct.tg_max = gamedict!["tg_max"] as? Int
                        gamestruct.tg_min = gamedict!["tg_min"] as? Int
                        gamestruct.tg_name = gamedict!["tg_name"] as? String
                        gamestruct.tg_introduction = gamedict!["tg_introduction"] as? String
                        gamestruct.photoUrl = gamedict!["photoUrl"] as? String
                        gamestruct.tg_class = gamedict!["tg_class"] as? String
                        
                        self.gamestructListFour.append(gamestruct)
                        //print(self.gamestructListTwo)
                    }
                }
                self.gameChoosePickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            //location: city
            nameRef.child("shop").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let mycityDict = snapshot.value as? [String:AnyObject] {
                    for cityname in mycityDict.keys {
                        self.cityNameArray.append(cityname)
                        //print(self.cityNameArray)
                    }
                    //print(mycityDict)
                }
                self.gameChoosePickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            //location
            nameRef.child("shop").child("高雄市").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    for areaname in myareaDict.keys {
                        self.areaNameArray.append(areaname)
                    }
                    //print(self.areaNameArray)
                    //print("Total number of posts: \(snapshot.childrenCount)")
                    for item in snapshot.children.allObjects as! [DataSnapshot] {
                        let postInfo = item.value as? [String: Any] ?? [:]
//
//                        print("-------")
//                        print("Post ID: \(item.key)")
//                        print(postInfo )
                        for (_,value) in postInfo {
                            let shopdict = value as? [String: Any]
                            //print(shopdict!["address"])
                            let shopinfo = ShopInfo()
                            shopinfo.address = shopdict!["address"] as? String
                            shopinfo.title = shopdict!["title"] as? String
                            shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                            shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                            shopinfo.tel = shopdict!["tel"] as? String
                            shopinfo.opentime = shopdict!["opentime"] as? String
                            shopinfo.closetime = shopdict!["closetime"] as? String
                            
                            self.areaNameListAll.append(shopinfo)
                            
                            
                            //List to array
                            self.areaNameArrayAll.append((shopdict!["title"] as? String)!)
                            //print(self.areaNameArrayAll)
                        }
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("三民區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        self.areaNameListOne.append(shopinfo)
                        self.areaNameArrayOne.append((shopdict!["title"] as? String)!)
                        
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("前鎮區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        self.areaNameListTow.append(shopinfo)
                        self.areaNameArrayTwo.append((shopdict!["title"] as? String)!)
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("左營區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        self.areaNameListThree.append(shopinfo)
                        self.areaNameArrayThree.append((shopdict!["title"] as? String)!)
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("新興區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        self.areaNameListFour.append(shopinfo)
                        self.areaNameArrayFour.append((shopdict!["title"] as? String)!)
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("苓雅區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        self.areaNameListFive.append(shopinfo)
                        self.areaNameArrayFive.append((shopdict!["title"] as? String)!)
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("鳳山區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        
                        self.areaNameListSix.append(shopinfo)
                        self.areaNameArraySix.append((shopdict!["title"] as? String)!)
                    }
                }
                self.locationChoosePickerView.reloadAllComponents()
                self.shopPickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            nameRef.child("shop").child("高雄市").child("鼓山區").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let myareaDict = snapshot.value as? [String:AnyObject] {
                    //print(myareaDict)
                    
                    for (_,value) in myareaDict {
                        let shopdict = value as? [String: Any]
                        //print(shopdict!["address"])
                        let shopinfo = ShopInfo()
                        shopinfo.address = shopdict!["address"] as? String
                        shopinfo.title = shopdict!["title"] as? String
                        shopinfo.map_latitude = shopdict!["map_latitude"] as? String
                        shopinfo.map_longitude = shopdict!["map_longitude"] as? String
                        shopinfo.tel = shopdict!["tel"] as? String
                        shopinfo.opentime = shopdict!["opentime"] as? String
                        shopinfo.closetime = shopdict!["closetime"] as? String
                        
                        self.areaNameListSeven.append(shopinfo)
                        self.areaNameArraySeven.append((shopdict!["title"] as? String)!)
                    }
                }
                self.shopPickerView.reloadAllComponents()
                self.locationChoosePickerView.reloadAllComponents()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            //上傳照片網址
            let storageRef = Storage.storage().reference()
            let userPhotoRef = storageRef.child("UserInfo").child(currentUser!.uid).child("profileImage.jpg")

            userPhotoRef.downloadURL { (url, error) in
                if error == nil {
                    self.userPhotoUrl = (url?.absoluteString)!
                } else {
                    let userurl = currentUser?.photoURL
                    self.userPhotoUrl = (userurl!.absoluteString)
                }
            }
            
            //print("\(self.userPhotoUrl)===============")
            
        }//end currentUser
    }//end loaddata
}//end GroupStartedViewController










