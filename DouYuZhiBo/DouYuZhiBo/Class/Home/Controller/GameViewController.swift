//
//  GameViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/22.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kGameViewHeaderH : CGFloat = 50
fileprivate let kHotGameViewH : CGFloat = 90
fileprivate let kGameViewMarggin : CGFloat = 12

fileprivate let kGameViewCellID = "gameViewCellID"
fileprivate let kGameViewHeaderViewID = "gameViewHeaderViewID"

class GameViewController: BaseViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var gameCollecView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kGameViewHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kGameViewMarggin, bottom: 0, right: kGameViewMarggin)
        
        let gameCollecView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        gameCollecView.backgroundColor = UIColor.white
        gameCollecView.dataSource = self
        gameCollecView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
        gameCollecView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        gameCollecView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameViewHeaderViewID)
        return gameCollecView
    }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.headerView()
        topHeaderView.frame = CGRect(x: 0, y: -(kGameViewHeaderH + kHotGameViewH), width: kScreenW, height: kGameViewHeaderH)
        topHeaderView.titLab.text = "热门"
        topHeaderView.iconImg.image = UIImage(named: "Img_orange")
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
    }()
    
    fileprivate lazy var hotGameView : RecommendGameView = {
        let hotGameView = RecommendGameView.recommendGameView()
        hotGameView.frame = CGRect(x: 0, y: -kHotGameViewH, width: kScreenW, height: kHotGameViewH)
        return hotGameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
        
        
    }

}


// MARK:  设置UI相关
extension GameViewController {

    override func setupUI() {
  
        view.addSubview(gameCollecView)
        
        gameCollecView.addSubview(topHeaderView)
        
        gameCollecView.addSubview(hotGameView)
        
        gameCollecView.contentInset = UIEdgeInsets(top: kGameViewHeaderH + kHotGameViewH, left: 0, bottom: 0, right: 0)
        
        
        baseContentView = gameCollecView
        
        super.setupUI()
        
    }
}

// MARK: 网络请求
extension GameViewController {
    
    fileprivate func loadData() {
        gameVM.requestData {
            
            self.gameCollecView.reloadData()
            
            self.hotGameView.roomList = Array(self.gameVM.games[0..<10])
            
            //请求数据完成,调用父类的,取消动画
            self.loadDataFinished()
        }
    }
}

extension GameViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! CollectionGameViewCell
        
        cell.roomList = gameVM.games[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameViewHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        header.titLab.text = "全部"
        header.iconImg.image = UIImage(named: "Img_orange")
        header.moreBtn.isHidden = true
        
        return header
    }
}
