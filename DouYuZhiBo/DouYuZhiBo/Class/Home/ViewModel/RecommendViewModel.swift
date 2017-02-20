//
//  RecommendViewModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/20.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class RecommendViewModel {

    /// 装载整个模型的数组
    lazy var room_list : [RoomListModel] = [RoomListModel]()
    
    /// 这个列表装的是 颜值 模块
    fileprivate lazy var prettyRoomList : RoomListModel = RoomListModel()
    
    /// 这个列表装的是 热门 模块
    fileprivate lazy var hotRoomList : RoomListModel = RoomListModel()
}


// MARK: -发送网络请求
extension RecommendViewModel {

    func loadData(completion : @escaping () -> ()) {
        
        // 1.先定义需要的参数
        let parameters : [String : Any] = ["limit" : "4",
                                           "offset" : "0",
                                           "time" : NSDate.getCurrentTime()]
        
        let group = DispatchGroup()
        group.enter()
        // 热门的
        NetworkTools.requestData(type: .GET,
                                 urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",
                                 parameters: ["time" : NSDate.getCurrentTime()]) {
                                    (result) in
                                    
                                    // 1.校验转字典
                                    guard let resultDict = result as? [String : Any] else { return }
                                    
                                    // 2.校验取值
                                    guard let data = resultDict["data"] as? [[String : Any]] else { return }
                                    
                                    // 3.取出值 然后遍历
                                    for room in data {
                                        let room = RoomModel(dict: room)
                                        self.hotRoomList.rooms.append(room)
                                    }
                                    
                                    group.leave()
                                    
        }
        
        group.enter()
        // 颜值的
        NetworkTools.requestData(type: .GET,
                                 urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",
                                 parameters: parameters) {
                                    (result) in
            
                                    // 1.校验转字典
                                    guard let resultDict = result as? [String : Any] else { return }
            
                                    // 2.校验取值
                                    guard let data = resultDict["data"] as? [[String : Any]] else { return }
            
                                    // 3.取出值 然后遍历
                                    for room in data {
                                        let room = RoomModel(dict: room)
                                        self.prettyRoomList.rooms.append(room)
                                    }
            
                                    group.leave()
            }
        
        group.enter()
        // 推荐最下面的 游戏的 数据
        NetworkTools.requestData(type: .GET,
                                 urlString: "http://capi.douyucdn.cn/api/v1/getHotCate",
                                 parameters: parameters) {
                                    (result) in
            
                                    // 1.校验转字典
                                    guard let resultDict = result as? [String : Any] else { return }
            
                                    // 2.校验取值
                                    guard let data = resultDict["data"] as? [[String : Any]] else { return }
            
                                    // 3.取出值 然后遍历
                                    for roomGroup in data {
            
                                        let roomGroup = RoomListModel(dict: roomGroup)
                
                                        // 201 是颜值模块 不需要这个模块 屏蔽
                                        if roomGroup.tag_id == 201 { continue }
                
                                        self.room_list.append(roomGroup)
                
                                    }
            
                                    group.leave()
            }

        group.notify(queue: DispatchQueue.main) { 
            self.room_list.insert(self.prettyRoomList, at: 0)
            self.room_list.insert(self.hotRoomList, at: 0)
            completion()
        }
    }
}
