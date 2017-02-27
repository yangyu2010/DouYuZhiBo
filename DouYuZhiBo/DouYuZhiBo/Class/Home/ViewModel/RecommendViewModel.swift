//
//  RecommendViewModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/20.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseRoomViewModel {

    /// 这个列表装的是 颜值 模块
    fileprivate lazy var prettyRoomList : RoomListModel = RoomListModel()
    
    /// 这个列表装的是 热门 模块
    lazy var hotRoomList : RoomListModel = RoomListModel()

}


// MARK: -发送网络请求
extension RecommendViewModel {

    // 请求推荐下数据
    func loadData(completion : @escaping () -> ()) {
        
        // 1.先定义需要的参数
        let parameters : [String : Any] = ["limit" : "4",
                                           "offset" : "0",
                                           "time" : NSDate.getCurrentTime()]
        
        // 2.设置自定义的两个group属性
        prettyRoomList.tag_name = "颜值"
        prettyRoomList.local_icon = "home_header_phone"
        
        hotRoomList.tag_name = "热门"
        hotRoomList.local_icon = "home_header_hot"
        
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
        super.requestData(urlSting: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) { 
            self.room_list.insert(self.prettyRoomList, at: 0)
            self.room_list.insert(self.hotRoomList, at: 0)
            completion()
        }
    }
    

    // 请求广告数据
    func loadRecycleViewData(completion : @escaping (_ recycleModelArr : [RecycleModel]) -> ()) {
        
        NetworkTools.requestData(type: .GET,
                                 urlString: "http://www.douyutv.com/api/v1/slide/6",
                                 parameters: ["version" : "2.300"]) {
                                    (result) in
            
                                    // 1.校验转字典
                                    guard let resultDict = result as? [String : Any] else { return }
                                    
                                    // 2.校验取值
                                    guard let data = resultDict["data"] as? [[String : Any]] else { return }
                                    
                                    var recycleModelArr = [RecycleModel]()
                                    
                                    // 3.遍历数组 转模型
                                    for dict in data {
                                        let model = RecycleModel(dict: dict)
                                        recycleModelArr.append(model)
                                    }
            
                                    completion(recycleModelArr)
        }
    }
}
