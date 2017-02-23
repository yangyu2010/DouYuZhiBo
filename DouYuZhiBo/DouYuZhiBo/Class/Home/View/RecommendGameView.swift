//
//  RecommendGameView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/22.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kGameViewCellID = "kGameViewCellID"

class RecommendGameView: UIView {

    // MARK: xib控件
    @IBOutlet weak var collecView: UICollectionView!
    
    var roomList : [RoomListModel]? {
        didSet {
            if let roomList = roomList,
                 roomList.count > 0 {
                collecView.reloadData()
            }
        }
    }
    
    
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
        collecView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
    }
    
}


extension RecommendGameView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! CollectionGameViewCell
        
        cell.roomList = roomList?[indexPath.item]
        
        return cell
    }
}

// MARK: 提供个类方法创建xib的view
extension RecommendGameView {

    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
        
    }
}
