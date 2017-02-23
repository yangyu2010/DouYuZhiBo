//
//  GameViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/22.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let gameViewCellID = "gameViewCellID"

class GameViewController: UIViewController {

    fileprivate lazy var gameCollecView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let gameCollecView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        gameCollecView.backgroundColor = UIColor.white
        gameCollecView.dataSource = self
        gameCollecView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: gameViewCellID)
        
        return gameCollecView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}


// MARK:  设置UI相关
extension GameViewController {

    fileprivate func setupUI() {
  
        view.addSubview(gameCollecView)
    }
}

extension GameViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewCellID, for: indexPath)
        
        //cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }

}
