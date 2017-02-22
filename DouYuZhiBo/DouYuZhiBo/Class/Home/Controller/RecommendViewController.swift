//
//  RecommendViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/16.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kRecommendMarggin: CGFloat = 10
fileprivate let kRecommendCellW: CGFloat = (kScreenW - 3 * kRecommendMarggin) / 2
fileprivate let kRecommendNormalCellH: CGFloat = kRecommendCellW * 3 / 4.0
fileprivate let kRecommendPrettyCellH: CGFloat = kRecommendCellW * 4 / 3.0
fileprivate let kRecommendHeaderViewH: CGFloat = 50

fileprivate let kRecycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH : CGFloat = 90

fileprivate let kRecommendNormalCellID = "kRecommendNormalCellID"
fileprivate let kRecommendPrettyCellID = "kRecommendPrettyCellID"
fileprivate let kRecommendHeaderView = "kRecommendHeaderView"

class RecommendViewController: UIViewController {

    // MARK: -懒加载属性
    fileprivate lazy var viewModel : RecommendViewModel = RecommendViewModel()

    // MARK: -懒加载控件
    fileprivate lazy var recommendCollec: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kRecommendCellW, height: kRecommendNormalCellH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kRecommendMarggin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kRecommendHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kRecommendMarggin, bottom: 0, right: kRecommendMarggin)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kNavigationH - 40 - kTabBarH)
        let collec = UICollectionView(frame: frame, collectionViewLayout: layout)
        collec.register(UINib(nibName: "CollectionViewNomalCell", bundle: nil), forCellWithReuseIdentifier: kRecommendNormalCellID)
        collec.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kRecommendPrettyCellID)
        collec.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommendHeaderView)
        collec.backgroundColor = UIColor.white
//        collec.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin]
        collec.dataSource = self
        collec.delegate = self
        return collec
    }()
    
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
    
    // MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }


}


// MARK: -设置UI
extension RecommendViewController {
    fileprivate func setupUI() {
        
        // 1.添加collectionView
        view.addSubview(recommendCollec)
        recommendCollec.dataSource = self
        
        // 2.添加头部广告View
        recommendCollec.addSubview(recycleView)
        
        // 3.设置collectionView的内边距
        recommendCollec.contentInset = UIEdgeInsets(top: kRecycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        // 4.添加gameView
        recommendCollec.addSubview(gameView)
        
    }
}

// MARK: -请求数据
extension RecommendViewController {

    func loadData() {
                
        viewModel.loadData { 
            self.recommendCollec.reloadData()
//            self.gameView.roomList = self.viewModel.room_list
            
            
            var groups = self.viewModel.room_list
            groups.removeFirst()
            groups.removeFirst()
            
            let list = RoomListModel()
            list.tag_name = "更多"
            groups.append(list)
            self.gameView.roomList = groups
        }
        
        viewModel.loadRecycleViewData { (recycleModelArr) in
            self.recycleView.recycleModelArr = recycleModelArr
        }
    }
}

// MARK: -CollectionView代理
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let list = viewModel.room_list[section]
        return list.rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommendHeaderView, for: indexPath) as! CollectionHeaderView
        headerView.roomList = viewModel.room_list[indexPath.section]
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if indexPath.section == 1 {
            return CGSize(width: kRecommendCellW, height: kRecommendPrettyCellH)
        }else {
            return CGSize(width: kRecommendCellW, height: kRecommendNormalCellH)
        }
    }
    
}





