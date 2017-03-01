//
//  FunnyViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/28.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kFunnyContentViewMaggin : CGFloat = 8

class FunnyViewController: BaseRoomViewController {

    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()

    override func setupUI() {
        super.setupUI()
        
        let layout = baseCollec.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        baseCollec.contentInset = UIEdgeInsets(top: kFunnyContentViewMaggin, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        
        viewModel = funnyVM
        
        funnyVM.requestFunnyData {
            
            self.baseCollec.reloadData()
            
            //请求数据完成,调用父类的,取消动画
            self.loadDataFinished()
        }
    }
}

