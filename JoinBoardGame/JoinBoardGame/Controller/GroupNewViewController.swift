//
//  GroupNewViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/17.
//  Copyright © 2018年 fileice. All rights reserved.
//
//第二版,使用mvvm模式

import UIKit
import Firebase

class GroupNewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    //searchBar
    var searchSongs = [Group_New]()
    open var searchController: UISearchController?
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        searchSongs = showGroup.filter { (name) -> Bool in
            return name.groupName.contains(searchString) || name.userName.contains(searchString) || name.gameName.contains(searchString) || name.groupMax.contains(searchString) || name.gameClassType.contains(searchString) || name.gameName.contains(searchString)
        }
        myTableView.reloadData()
    }
    
    
    var showGroup: [Group_New] = []
    var hideGroup: [Group_Two] = []
    fileprivate var isLoadingGroup = false
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        self.myTableView.rowHeight = 230
        
        //self.myTableView.backgroundView = UIImageView(image: UIImage(named: "灰色漸層"))
        
        loadRecentPosts()
        //loadHindPosts()
        // Configure the pull to refresh
        
        refreshControl.backgroundColor = UIColor.black
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(loadRecentPosts), for: UIControlEvents.valueChanged)

        // Do any additional setup after loading the view.
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if #available(iOS 11.0, *) {
            if navigationItem.searchController?.isActive == true {
                return searchSongs.count
            } else {
                return showGroup.count
            }
        } else {
            // Fallback on earlier versions
            return showGroup.count
        }
        //return showGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupNewTableViewCell

        
        if #available(iOS 11.0, *) {
            if navigationItem.searchController?.isActive == true {
                //cell.textLabel?.text = searchSongs[indexPath.row]
                let currentPost = searchSongs[indexPath.row]
                cell.configure(group: currentPost)
                
                cell.layer.borderWidth = 1
                cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                
                cell.backgroundColor = UIColor.clear
            } else {
                let currentPost = showGroup[indexPath.row]
                cell.configure(group: currentPost)
                
                cell.layer.borderWidth = 1
                cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                
                //cell.backgroundColor = UIColor.clear
                //cell.textLabel?.text = songs[indexPath.row]
            }
        } else {
            let currentPost = showGroup[indexPath.row]
            cell.configure(group: currentPost)
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            
            //cell.backgroundColor = UIColor.clear
        }
        return cell
    
        
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupNewTableViewCell
        
//        let currentPost = showGroup[indexPath.row]
//        cell.configure(group: currentPost)
//
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        cell.layer.cornerRadius = 10
//        cell.layer.masksToBounds = true
//
//        cell.backgroundColor = UIColor.clear
        //cell.backgroundView = UIImageView(image: UIImage(named: "灰色漸層"))
       // return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let navigator = navigationController {
            let myGroupDetailVC: GroupDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "GroupVC") as! GroupDetailViewController
            let aaa = hideGroup[indexPath.row]
            let bbb = showGroup[indexPath.row]
            myGroupDetailVC.hidesBottomBarWhenPushed = true
            
            myGroupDetailVC.address = aaa.shopAddress
            myGroupDetailVC.map_latitude = aaa.map_latitude
            myGroupDetailVC.map_longitude = aaa.map_longtitude
            myGroupDetailVC.shopTel = aaa.shopTel
            myGroupDetailVC.opentime = aaa.opentime
            myGroupDetailVC.closetime = aaa.closetime
            
            myGroupDetailVC.cityName = bbb.cityName
            myGroupDetailVC.gameClassType = bbb.gameClassType
            myGroupDetailVC.gameName = bbb.gameName
            myGroupDetailVC.groupEndTime = bbb.groupEndTime
            myGroupDetailVC.groupMax = bbb.groupMax
            myGroupDetailVC.groupMin = bbb.groupMin
            myGroupDetailVC.groupName = bbb.groupName
            myGroupDetailVC.shopName = bbb.shopName
            myGroupDetailVC.groupStartTime = bbb.groupStartTime
            myGroupDetailVC.userName = bbb.userName
            myGroupDetailVC.userId = bbb.userId
            myGroupDetailVC.userPhotoUrl = bbb.userPhotoUrl
            
            //print("aaa")
            myGroupDetailVC.title = "開團資訊"
            navigator.pushViewController(myGroupDetailVC, animated: true)
            
        }
    }
    
    
    @objc fileprivate func loadRecentPosts() {
        
        isLoadingGroup = true
        
        Group_SimpleService.shared.getRecentPosts(completionHandler: { (newPosts) in
            if newPosts.count > 0 {
                // Add the array to the beginning of the posts arrays
                self.showGroup.insert(contentsOf: newPosts, at: 0)
            }
            self.isLoadingGroup = false
            self.displayNewPosts(newPosts: newPosts)
        })
        
        GroupService.shared.getRecentPosts(completionHandler: { (newPosts) in
            if newPosts.count > 0 {
                // Add the array to the beginning of the posts arrays
                self.hideGroup.insert(contentsOf: newPosts, at: 0)
            }
            self.isLoadingGroup = false
            
        })
    }
    
//    @objc fileprivate func loadHindPosts() {
//
//        isLoadingGroup = true
//
//        GroupService.shared.getRecentPosts(completionHandler: { (newPosts) in
//            if newPosts.count > 0 {
//                // Add the array to the beginning of the posts arrays
//                self.hideGroup.insert(contentsOf: newPosts, at: 0)
//            }
//            self.isLoadingGroup = false
//            self.displayHidePosts(newPosts: newPosts)
//        })
//    }
    
        
    private func displayNewPosts(newPosts posts: [Group_New]) {
        // 確認我們取得新的貼文來顯示
        guard posts.count > 0 else {
            return
        }
        
        //  將它們插入表格視圖中來顯示貼文
        var indexPaths:[IndexPath] = []
        self.myTableView.beginUpdates()
        for num in 0...(posts.count - 1) {
            let indexPath = IndexPath(row: num, section: 0)
            indexPaths.append(indexPath)
        }
        self.myTableView.insertRows(at: indexPaths, with: .fade)
        self.myTableView.endUpdates()
    }
    
//    private func displayHidePosts(newPosts posts: [Group_Two]) {
//        // 確認我們取得新的貼文來顯示
//        guard posts.count > 0 else {
//            return
//        }
//
//        //  將它們插入表格視圖中來顯示貼文
//        var indexPaths:[IndexPath] = []
//        self.myTableView.beginUpdates()
//        for num in 0...(posts.count - 1) {
//            let indexPath = IndexPath(row: num, section: 0)
//            indexPaths.append(indexPath)
//        }
//        self.myTableView.insertRows(at: indexPaths, with: .fade)
//        self.myTableView.endUpdates()
//    }



}











