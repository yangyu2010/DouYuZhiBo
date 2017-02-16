//
//  UIColor-Extension.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/15.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit


extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)

    }
    
    class func randomColor() -> UIColor {
        
        return UIColor(r: CGFloat(arc4random_uniform(225)), g: CGFloat(arc4random_uniform(225)), b: CGFloat(arc4random_uniform(225)) )
    }
}
