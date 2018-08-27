//
//  UIImage+Scale.swift
//  JoinBoardGame
//
//  Created by fileice on 2018/7/13.
//  Copyright © 2018年 fileice. All rights reserved.
//

import UIKit

extension UIImage {
    func scale(newWidth: CGFloat) -> UIImage {
        //確認寬度
        if self.size.width == newWidth {
            return self
        }
        
        //計算縮放
        let scaleFactor = newWidth / self.size.width
        let newHeight = self.size.height * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
        
    }
}
