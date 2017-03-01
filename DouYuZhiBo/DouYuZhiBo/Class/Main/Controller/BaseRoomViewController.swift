//
//  BaseRoomViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/27.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kRecommendMarggin: CGFloat = 10
fileprivate let kRecommendHeaderViewH: CGFloat = 50

let kRecommendCellW: CGFloat = (kScreenW - 3 * kRecommendMarggin) / 2
let kRecommendNormalCellH: CGFloat = kRecommendCellW * 3 / 4.0
let kRecommendPrettyCellH: CGFloat = kRecommendCellW * 4 / 3.0
let kRecommendNormalCellID = "kRecommendNormalCellID"
let kRecommendPrettyCellID = "kRecommendPrettyCellID"

fileprivate let kRecommendHeaderView = "kRecommendHeaderView"

class BaseRoomViewController: BaseViewController {

    // MARK: -懒加载属性
    var viewModel : BaseRoomViewModel!
    
    // MARK: -懒加载控件
    lazy var baseCollec: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kRecommendCellW, height: kRecommendNormalCellH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kRecommendMarggin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kRecommendHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kRecommendMarggin, bottom: 0, right: kRecommendMarggin)
        
        let collec = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collec.register(UINib(nibName: "CollectionViewNomalCell", bundle: nil), forCellWithReuseIdentifier: kRecommendNormalCellID)
        collec.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kRecommendPrettyCellID)
        collec.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommendHeaderView)
        collec.backgroundColor = UIColor.white
        collec.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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
extension BaseRoomViewController {
    
    override func setupUI() {
        
        // 1.设置父类的view
        baseContentView = baseCollec
        
        // 2.添加collectionView
        view.addSubview(baseCollec)

        // 3.调用父类的setupUI
        super.setupUI()
    }
}

// MARK: -请求数据
extension BaseRoomViewController {
    
    func loadData() {
        
    }
}


extension BaseRoomViewController : UICollectionViewDataSource {
    
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendNormalCellID, for: indexPath) as! CollectionViewNomalCell
        
        cell.room  = room
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommendHeaderView, for: indexPath) as! CollectionHeaderView
        headerView.roomList = viewModel.room_list[indexPath.section]
        return headerView
    }
}



extension BaseRoomViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let list = viewModel.room_list[indexPath.section]
        let room = list.rooms[indexPath.item]
        
        room.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
        
    }
    
    fileprivate func presentShowRoomVC() {
        let room = RoomShowViewController()
        present(room, animated: true, completion: nil)
    }
    
    fileprivate func pushNormalRoomVC() {
        let room = RoomNormalViewController()
        navigationController?.pushViewController(room, animated: true)
    }
}




