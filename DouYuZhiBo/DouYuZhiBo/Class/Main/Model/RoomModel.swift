//
//  RoomModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/20.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class RoomModel: NSObject {

    /// 房间name
    var room_name : String?
    
    /// 用户昵称
    var nickname : String?
    
    /// 在线观看人数
    var online : Int = 0
    
    /// 图片
    var vertical_src : String?
    
    /// 房间id
    var room_id : Int = 0
    
    /// 主播的城市
    var anchor_city : String?
    
    /// 1 手机直播  0 电脑直播
    var isVertical : Int = 0
    
    init(dict : [String : Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
