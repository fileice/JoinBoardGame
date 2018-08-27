//
//  MembersViewController.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/10.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit
import MessageUI

class MembersViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var btnContactUS: LineButton!
    
    @IBAction func btnContact_Click(_ sender: Any) {
    }
    
    @IBOutlet weak var btnAboutUS: LineButton!
    
    @IBAction func btnAboutUS_Click(_ sender: Any) {
    }
    
    @IBOutlet weak var btnDonate: LineButton!
    
    @IBAction func btnDonate_Click(_ sender: Any) {
        let donateAlertcontroller = UIAlertController(title: "恭喜成為VIP", message: "因為您的支持，我們會持續更新，有任何問題請寄信給我們，感謝您！", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default, handler: nil)
        donateAlertcontroller.addAction(okAction)
        self.present(donateAlertcontroller,animated: true,completion: nil)
        
    }
    
    @IBOutlet weak var btnDisclaimer: LineButton!
    
    @IBAction func btnDisclaimer_Click(_ sender: Any) {
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["join.boardgame.iii@gmail.com"])
        mailComposerVC.setSubject("太欣賞你們了!")
        mailComposerVC.setMessageBody("您們的APP做得真好!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "無法發送電子郵件", message: "您的設備無法發送電子郵件。請檢查電子郵件配置，然後重試。", preferredStyle: UIAlertControllerStyle.alert)
        sendMailErrorAlert.show(sendMailErrorAlert, sender: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindtoWelcomeView(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
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
