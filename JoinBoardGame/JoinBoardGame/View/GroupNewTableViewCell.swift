//
//  GroupNewTableViewCell.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/8/17.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit

class GroupNewTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var groupimageView: UIImageView!
    @IBOutlet weak var lblGroupName: UILabel!
    @IBOutlet weak var lblGameClass: UILabel!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var lblMemberCount: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblShopName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupimageView.clipsToBounds = true
        groupimageView.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private var currentPost: Group_New?
    
    func configure(group: Group_New) {

        // 設定 Cell 樣式
        selectionStyle = .none

        // 設定姓名與按讚數
        lblGroupName.text = group.groupName
        lblUserName.text = group.userName
        lblGameName.text = group.gameName
        lblShopName.text = group.shopName
        lblMemberCount.text = group.groupMax
        lblGameClass.text = group.gameClassType

        // 重設圖片視圖的圖片
        groupimageView.image = nil

        // 下載貼文圖片
        if let image = CacheManager.shared.getFromCache(key: group.photoUrl) as? UIImage {
            groupimageView.image = image

        } else {
            if let url = URL(string: group.photoUrl) {

                let downloadTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                    guard let imageData = data else {
                        return
                    }
                    
                    OperationQueue.main.addOperation {
                        guard let image = UIImage(data: imageData) else { return }

                        if self.currentPost?.photoUrl == group.photoUrl {
                            self.groupimageView.image = image
                        }
                        // 加入下載圖片至快取
                        CacheManager.shared.cache(object: image, key: group.photoUrl)
                    }
                })
                downloadTask.resume()
            }
        }
    }
}
