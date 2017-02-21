//
//  RecycleModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class RecycleModel: NSObject {

    /// 标题
    var title : String?
    
    /// 图片
    var pic_url : String?
    
    /// room
    var room : RoomModel?
    
    
    init(dict : [String : Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
        if let room = dict["room"] as? [String : Any] {
            self.room = RoomModel(dict: room)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
