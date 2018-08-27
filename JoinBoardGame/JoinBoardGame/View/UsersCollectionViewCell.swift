//
//  UsersCollectionViewCell.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/12.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit

class UsersCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lbluserName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeItRound()
    }
    
    func makeItRound() {
        self.userImageView.layer.masksToBounds = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2.0
        
    }
    
    
    
}
