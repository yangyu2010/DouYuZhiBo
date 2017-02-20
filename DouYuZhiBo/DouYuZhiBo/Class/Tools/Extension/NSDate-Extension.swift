//
//  NSDate-Extension.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/20.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import Foundation


extension NSDate {

    class func getCurrentTime() -> String {
        
        let date = NSDate()
        let interval = date.timeIntervalSince1970
        
        return "\(interval)"
    }
}
