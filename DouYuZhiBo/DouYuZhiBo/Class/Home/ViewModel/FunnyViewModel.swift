//
//  FunnyViewModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/28.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseRoomViewModel {

    func requestFunnyData(completion: @escaping () -> ()) {
        
        let dict = ["limit" : "30", "offset" : "0"]
        
        super.requestData(isGroup: false, urlSting: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: dict, completion: completion)
    }
}
