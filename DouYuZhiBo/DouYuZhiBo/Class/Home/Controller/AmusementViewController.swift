//
//  AmusementViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/27.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kAmusementHeaderViewH : CGFloat = 200
fileprivate let kHeaderCellTotalNumber : Int = 8

class AmusementViewController: BaseRoomViewController {

    fileprivate lazy var amusementViewModel : AmusementViewModel = AmusementViewModel()
    
    fileprivate lazy var headerView : AmusementHeaderView = {
    
        let headerView = AmusementHeaderView.amusementHeaderView()
        headerView.frame = CGRect(x: 0, y: -kAmusementHeaderViewH, width: kScreenW, height: kAmusementHeaderViewH)
        return headerView
    }()
}


extension AmusementViewController {

    override func setupUI() {
        
        super.setupUI()
        
        baseCollec.addSubview(headerView)
        
        baseCollec.contentInset = UIEdgeInsets(top: kAmusementHeaderViewH, left: 0, bottom: 0, right: 0)
    }
}


extension AmusementViewController {
    
    override func loadData() {
        
        // 1.先父类的ViewModel赋值
        viewModel = amusementViewModel
        
        // 2.请求数据,刷新collectionView
        amusementViewModel.requestAmusementData {
            self.baseCollec.reloadData()
            
            var tempArr = self.amusementViewModel.room_list
            tempArr .removeFirst()
            
            let totalCount = tempArr.count / kHeaderCellTotalNumber + 1
            var arr = [[RoomListModel]]()
            
            for i in 0..<totalCount {
                
                let startIndex = kHeaderCellTotalNumber * i
                var endIndex = (i + 1) * kHeaderCellTotalNumber - 1
                if endIndex > tempArr.count - 1 {
                    endIndex = tempArr.count - 1
                }
                
                let temp = tempArr[startIndex...endIndex]
                arr.append(Array(temp))
            }
 
            
            self.headerView.dataArr = arr
            
            //请求数据完成,调用父类的,取消动画
            self.loadDataFinished()
        }
    }
}



