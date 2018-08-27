//
//  GameIntroductionViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//
//使用webView

import UIKit

class GameIntroductionViewController: UIViewController {
    
    
    @IBOutlet weak var myWebView: UIWebView!
    
    
    
    @IBOutlet weak var gameTableView: UITableView!
    
    var mydict:[[String:Any]] = []
    
    //let url = URL(string: "http://13.230.60.250/gameintroduction.json")
    
    //let url = URL(string: "https://iii101-3.iii.wpj.tw/gameintroduction.json")
    //let url = URL(string: "https://iii101-3.iii.wpj.tw:8443/CallMeDB/111.jsp")
  
    let url = URL(string: "https://iii101-3.iii.wpj.tw/boardgame.html")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myWebView.loadRequest(URLRequest(url: url!))
        
        
        
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
    
//    var myArray = [GameAnswer]()
//    var gamejsonarray = [GameDetailsStruct]()
//
//    func downloadJson() {
//        guard let downloadURL = url else { return }
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: downloadURL, completionHandler: { (data, urlResponse, error) -> Void in
//            if let  error = error {
//                print("Json Download error by \(error.localizedDescription)")
//                return
//            }
//            let data = data!
//            do {
//                let results: [[String: AnyObject]] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : AnyObject]]
//
//                self.mydict = results
//
//                print("未解碼\(results)")
//
//                let decoder = JSONDecoder()
//                self.gamejsonarray = try decoder.decode([GameDetailsStruct].self, from: data)
//
//                //print("解碼後:\(self.gamejsonarray)")
//
//                for aaa in self.gamejsonarray {
//                    let game = GameAnswer(tgid: aaa.tg_id, tgname: aaa.tg_name, tgmax: aaa.tg_max, tgmin: aaa.tg_min, tgclass: aaa.tg_class, tginstroduction: aaa.tg_introduction)
//                    self.myArray.append(game)
//                }
//                for i in 0...7 {
//                    print(self.myArray[i].tg_class)
//                }
//
//
//                //                print(self.myArray[0].tg_id)
//                //                print(self.myArray[0].tg_name)
//                //                print(self.myArray[0].tg_introduction)
//                //                print(self.myArray.count)
//                //                print(self.myArray[1].tg_name)
//
//                DispatchQueue.main.async {
//                    self.gameTableView.reloadData()
//                }
//
//            }
//            catch {
//                print("error")
//            }
//        })
//        task.resume()
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
//    /////tableview potocol
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as UITableViewCell
//
//        cell.textLabel?.text = "遊戲名稱：\(myArray[indexPath.row].tg_name)"
//
//        return cell
//    }
    
    
    
    
    
    
    
}
