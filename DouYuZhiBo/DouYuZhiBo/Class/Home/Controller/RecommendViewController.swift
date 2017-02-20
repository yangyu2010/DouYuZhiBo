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

fileprivate let kRecommendNormalCellID = "kRecommendNormalCellID"
fileprivate let kRecommendPrettyCellID = "kRecommendPrettyCellID"
fileprivate let kRecommendHeaderView = "kRecommendHeaderView"

class RecommendViewController: UIViewController {

    fileprivate lazy var viewModel : RecommendViewModel = RecommendViewModel()
    
    // MARK: -懒加载属性
    fileprivate lazy var recommendCollec: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kRecommendCellW, height: kRecommendNormalCellH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kRecommendMarggin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kRecommendHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kRecommendMarggin, bottom: 0, right: kRecommendMarggin)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kNavigationH - 40 - kTabBarH)
        let collec = UICollectionView(frame: frame, collectionViewLayout: layout)
        collec.showsVerticalScrollIndicator = false
        collec.register(UINib(nibName: "CollectionViewNomalCell", bundle: nil), forCellWithReuseIdentifier: kRecommendNormalCellID)
        collec.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kRecommendPrettyCellID)
        collec.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommendHeaderView)
        collec.backgroundColor = UIColor.white
//        collec.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin]
        collec.dataSource = self
        collec.delegate = self
        return collec
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }


}


// MARK: -设置UI
extension RecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(recommendCollec)
        recommendCollec.dataSource = self
    }
}

// MARK: -请求数据
extension RecommendViewController {

    func loadData() {
                
        viewModel.loadData { 
            
            print(self.viewModel.room_list)
            
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
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            cell.room  = room
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendNormalCellID, for: indexPath) as! CollectionViewNomalCell
            cell.room  = room

            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommendHeaderView, for: indexPath)
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





