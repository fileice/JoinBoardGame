//
//  mainTabBarViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/17.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit

class mainTabBarViewController: UITabBarController {
    
    @IBOutlet weak var myTabbar: UITabBar!
    
    override func viewWillLayoutSubviews() {
        var tabFrame: CGRect = self.myTabbar.frame
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.myTabbar.frame = tabFrame
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTabbar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //文字颜色还原
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: UIControlState.selected)
        
        //#343a40  696969

       
        
        

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
