//
//  RecommendViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/16.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kRecycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH : CGFloat = 90

class RecommendViewController: BaseRoomViewController {

    // MARK: -懒加载属性
    fileprivate lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()

    fileprivate lazy var recycleView : RecycleHeaderView = {
        let recycleView = RecycleHeaderView.creatView()
        recycleView.frame = CGRect(x: 0, y: -(kRecycleViewH + kGameViewH), width: kScreenW, height: kRecycleViewH)
        return recycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    

}


// MARK: -设置UI
extension RecommendViewController {
    
    override func setupUI() {
        
        // 1.添加collectionView -- 调用父类的方法
        super.setupUI()
        
        // 2.添加头部广告View
        baseCollec.addSubview(recycleView)
        
        // 3.添加gameView
        baseCollec.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        baseCollec.contentInset = UIEdgeInsets(top: kRecycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)

    }
}

// MARK: -请求数据
extension RecommendViewController {

    override func loadData() {
        
        viewModel = recommendViewModel
        
        recommendViewModel.loadData {
            self.baseCollec.reloadData()
//            self.gameView.roomList = self.viewModel.room_list
            
            
            var groups = self.viewModel.room_list
            groups.removeFirst()
            groups.removeFirst()
            
            let list = RoomListModel()
            list.tag_name = "更多"
            groups.append(list)
            self.gameView.roomList = groups
        }
        
        recommendViewModel.loadRecycleViewData { (recycleModelArr) in
            self.recycleView.recycleModelArr = recycleModelArr
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = viewModel.room_list[indexPath.section]
        let room = list.rooms[indexPath.item]
        
        var cell : CollectionViewBaseCell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendNormalCellID, for: indexPath) as! CollectionViewNomalCell
        }
        
        cell.room  = room
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        if indexPath.section == 1 {
           return CGSize(width: kRecommendCellW, height: kRecommendPrettyCellH)
        }else {
            return CGSize(width: kRecommendCellW, height: kRecommendNormalCellH)
        }
    }
    
}

//
//// MARK: -CollectionView代理
//extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return viewModel.room_list.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        let list = viewModel.room_list[section]
//        return list.rooms.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let list = viewModel.room_list[indexPath.section]
//        let room = list.rooms[indexPath.item]
//        
//        var cell : CollectionViewBaseCell
//        if indexPath.section == 1 {
//             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
//        } else {
//             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendNormalCellID, for: indexPath) as! CollectionViewNomalCell
//        }
//        cell.room  = room
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommendHeaderView, for: indexPath) as! CollectionHeaderView
//        headerView.roomList = viewModel.room_list[indexPath.section]
//        return headerView
//    }
//    
//    

//}
//




