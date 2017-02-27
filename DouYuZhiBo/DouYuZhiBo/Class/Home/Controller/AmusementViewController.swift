//
//  AmusementViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/27.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class AmusementViewController: BaseRoomViewController {

    fileprivate lazy var amusementViewModel : AmusementViewModel = AmusementViewModel()
}

extension AmusementViewController {
    
    override func loadData() {
        
        // 1.先父类的ViewModel赋值
        viewModel = amusementViewModel
        
        // 2.请求数据,刷新collectionView
        amusementViewModel.requestAmusementData {
            self.baseCollec.reloadData()
        }
    }
}



