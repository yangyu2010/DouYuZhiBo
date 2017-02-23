//
//  GameViewModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/23.
//  Copyright © 2017年 YuYang. All rights reserved.
//  http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game

import UIKit

class GameViewModel {
    
    lazy var games : [RoomListModel] = [RoomListModel]()

    func requestData(completion : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let arr = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in arr {
                let room = RoomListModel(dict: dict)
                self.games.append(room)
            }
            
            completion()
            
        }
    }
}
