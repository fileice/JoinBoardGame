//
//  IndexPageViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//
//第一版,mvc模式,讀取資料過多造成tableview緩慢

import UIKit
import Firebase
import FirebaseDatabase


class IndexPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var aivLoadingView: UIActivityIndicatorView!
    //tableView下拉更新
    var refreshControl: UIRefreshControl!

    func pullToRefreshHistoryMessages(){

        //get history message data …
        
        
        self.refreshControl.endRefreshing()
    }


    @IBOutlet weak var mytableView: UITableView!
    
    func showActivityIndicatory(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(white: 0xffffff, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width/2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        
        uiView.addSubview(container)
        actInd.startAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView.delegate = self
        mytableView.dataSource = self
        
        
        
        //aivLoadingView.startAnimating()
        let aivView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aivView.color = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        aivView.startAnimating()
        mytableView.backgroundView = aivView
        
        self.refreshControl = UIRefreshControl()
        self.mytableView.addSubview(refreshControl)
        pullToRefreshHistoryMessages()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /******* start tableView potocol *****************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
        //return 10
        //return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = mytableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        let groupSimple = groupList[indexPath.row]

        
        let myImageURL: URL = URL(string: groupSimple.boardGamePhotoUrl!)!
        let myImageData: Data = try! Data(contentsOf: myImageURL)
        //cell.groupImageView.image = UIImage(data: myImageData)
        
        let image = UIImage(data: myImageData)
        
        cell.textLabel?.text = "團名:\(groupSimple.groupName!)"
        cell.detailTextLabel?.text = "遊戲名稱:\(groupSimple.gameName!)\n團長:\(groupSimple.userName!)\n開團地點:\(groupSimple.shopName!)\n"
        cell.detailTextLabel?.numberOfLines = 4
        
        if image != nil {
            cell.imageView?.image = image
        }
        
        
        cell.layer.cornerRadius = 30
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.clipsToBounds = true


        //cell.groupImageView.image = UIImage(named: "logo_灰底白框")
//        cell.lblGameName.text = "遊戲名稱:\(groupSimple.gameName!)"
//        cell.lblGroupName.text = "團名:\(groupSimple.groupName!)"
//        cell.lblUserName.text = "團長:\(groupSimple.userName!)"
//        cell.lblAddress.text = "開團地點:\(groupSimple.shopName!)"
//        cell.lblMemberCount.text = "人數:\((Int(groupSimple.groupMax!)!))"
//        cell.lblTime.text = "\(groupSimple.groupStartTime!)"
        
        
        
//
//        cell.lblGameName.text = "遊戲名稱"
//        cell.lblGroupName.text = "團名"
//        cell.lblUserName.text = "團長"
//        cell.lblAddress.text = "開團地點:"
//        cell.lblMemberCount.text = "人數:)"
//        cell.lblTime.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myGroupDetailVC: GroupDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "GroupVC") as! GroupDetailViewController
        let groupSimple = groupList[indexPath.row]
        let groups = groupsList[indexPath.row]
        
        
        myGroupDetailVC.address = groups.shopAddress!
        myGroupDetailVC.map_latitude = groups.map_latitude!
        myGroupDetailVC.map_longitude = groups.map_longtitude!
        myGroupDetailVC.shopTel = groups.shopTel!
        myGroupDetailVC.opentime = groups.opentime!
        myGroupDetailVC.closetime = groups.closetime!
        
        myGroupDetailVC.cityName = groupSimple.cityName!
        myGroupDetailVC.gameClassType = groupSimple.gameClassType!
        myGroupDetailVC.gameName = groupSimple.gameName!
        myGroupDetailVC.groupEndTime = groupSimple.groupEndTime!
        myGroupDetailVC.groupMax = groupSimple.groupMax!
        myGroupDetailVC.groupMin = groupSimple.groupMin!
        myGroupDetailVC.groupName = groupSimple.groupName!
        myGroupDetailVC.shopName = groupSimple.shopName!
        myGroupDetailVC.groupStartTime = groupSimple.groupStartTime!
        myGroupDetailVC.userName = groupSimple.userName!
        myGroupDetailVC.userId = groupSimple.userId!
        myGroupDetailVC.userPhotoUrl = groupSimple.userPhotoUrl!
        
        myGroupDetailVC.title = "開團資訊"
        self.navigationController?.show(myGroupDetailVC, sender: nil)
    }
    
    var group_All_List = [Group_All]()
    
    /******* end tableView potocol *****************/
    
    var groupList = [Group_Simple]()
    var groupsList = [Groups]()
    var groupMembers = [Group_Simple]()
    var memberList = [Members]()
    
    func loadData() {
        groupList.removeAll()
        groupsList.removeAll()
        
        //let currentUser = Auth.auth().currentUser
        
        let userRef = Database.database().reference()
        userRef.child("group_simple").observeSingleEvent(of: .value, with: { (snapshot) in

            if let mygroupDict = snapshot.value as? [String:AnyObject] {
                //print(mygroupDict)

                for (userId,value) in mygroupDict {
                    //print(mygroupDict)
                    let groupdict = value as? [String: Any]
                    //print(groupdict!["cityName"])
                    var groupInfo = Group_Simple()
                    
                    
                    groupInfo.cityName = groupdict!["cityName"] as? String
                    groupInfo.gameClassType = groupdict!["gameClassType"] as? String
                    groupInfo.gameName = groupdict!["gameName"] as? String
                    groupInfo.groupEndTime = groupdict!["groupEndTime"] as? String
                    groupInfo.groupMax = groupdict!["groupMax"] as? String
                    groupInfo.groupMin = groupdict!["groupMin"] as? String
                    groupInfo.groupName = groupdict!["groupName"] as? String
                    groupInfo.groupStartTime = groupdict!["groupStartTime"] as? String
                    groupInfo.shopName = groupdict!["shopName"] as? String
                    groupInfo.userName = groupdict!["userName"] as? String
                    groupInfo.boardGamePhotoUrl = groupdict!["photoUrl"] as? String
                    groupInfo.userPhotoUrl = groupdict!["userPhotoUrl"] as? String
                    groupInfo.userId = userId

                    self.groupList.append(groupInfo)
                    //print(groupdict!["boardGamePhotoUrl"])
                }
                //print(self.groupList)
                self.mytableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        

        
        userRef.child("groups").observeSingleEvent(of: .value, with: { (snapshot) in

            if let mygroupDict = snapshot.value as? [String:AnyObject] {
                //print(mygroupDict)

                for (_,value) in mygroupDict {
                    //print(mygroupDict)
                    let groupdict = value as? [String: Any]
                    //print(groupdict!["cityName"])
                    var groupInfo = Groups()

                    groupInfo.map_latitude = groupdict!["map_latitude"] as? String
                    groupInfo.map_longtitude = groupdict!["map_longtitude"] as? String
                    groupInfo.shopAddress = groupdict!["shopAddress"] as? String
                    groupInfo.shopTel = groupdict!["shopTel"] as? String
                    groupInfo.opentime = groupdict!["opentime"] as? String
                    groupInfo.closetime = groupdict!["closetime"] as? String
                    self.groupsList.append(groupInfo)

                }
                //print(self.groupsList)
                self.mytableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }

        
        //self.aivLoadingView.stopAnimating()
    }//end loaddata
}
