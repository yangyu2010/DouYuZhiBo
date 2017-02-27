//
//  AmusementViewModel.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/27.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class AmusementViewModel: BaseRoomViewModel {

    func requestAmusementData(completion : @escaping () -> ()) {
        super.requestData(urlSting: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, completion: completion)
    }
    
}
