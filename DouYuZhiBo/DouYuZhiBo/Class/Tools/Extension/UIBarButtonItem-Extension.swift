//
//  UIBarButtonItem-Extension.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/14.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
    
    
}
