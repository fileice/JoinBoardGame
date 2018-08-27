//
//  NewGameIntroductionViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/7.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import Firebase

class NewGameIntroductionViewController: UIViewController {
    
    @IBOutlet weak var gameTableView: UITableView!
    
    let url = URL(string: "https://iii101-3.iii.wpj.tw/game_Introduction.json")

    override func viewDidLoad() {
        super.viewDidLoad()

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
