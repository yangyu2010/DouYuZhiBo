//
//  RoomListModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/20.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class RoomListModel: NSObject {

    /// 装房间的数组
    var rooms : [RoomModel] = [RoomModel]()
    
    /// 房间列表
    var room_list : [[String : Any]]?
    /// group图标
    var icon_url : String?
    /// group标题
    var tag_name : String?
    /// id
    var tag_id : Int = 0
    /// 本地group图片
    var local_icon : String = "home_header_normal"
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
        // 对房间列表遍历
        if let room_lists = dict["room_list"] as? [[String : Any]] {
            
            for anchorDict in room_lists {
                
                let anchor = RoomModel(dict : anchorDict)
                
                rooms.append(anchor)
            }
            
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
