//
//  BaseRoomViewModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/27.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class BaseRoomViewModel {

    /// 装载整个模型的数组
    lazy var room_list : [RoomListModel] = [RoomListModel]()
    
    func requestData( urlSting : String, parameters : [String : Any]? ,completion : @escaping () -> ()) {
        
        NetworkTools.requestData(type: .GET, urlString: urlSting, parameters: parameters) { (result) in
            
            //1.校验转字典
            guard let resultDict = result as? [String : Any] else { return }
            
            // 2.校验取值
            guard let data = resultDict["data"] as? [[String : Any]] else { return }
            
            // 3.取出值 然后遍历
            for roomGroup in data {
                
                let roomGroup = RoomListModel(dict: roomGroup)
                
                //201 是颜值模块 不需要这个模块 屏蔽
                if roomGroup.tag_id == 201 { continue }
                
                self.room_list.append(roomGroup)
                
            }
            completion()
            
        }
    }
}
