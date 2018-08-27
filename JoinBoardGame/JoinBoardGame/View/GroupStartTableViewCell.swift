//
//  GroupStartTableViewCell.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/30.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit

class GroupStartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var lblGroupName: UILabel!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblMemberCount: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    struct Group_Simple {

        let cityName: String
        let gameClassType: String
        let gameName: String
        let groupEndTime: String
        let groupMax: String
        let groupMin: String
        let groupName: String
        let groupStartTime: String
        let shopName: String
        let userName: String
        
    }
    
    struct Groups {
        let map_latitude: String
        let map_longtitude: String
        let shopAddress: String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupImageView.clipsToBounds = true
        groupImageView.layer.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
