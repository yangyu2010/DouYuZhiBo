//
//  AmusementHeaderCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/28.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

private let kHeaderCellID = "kHeaderCellID"

class AmusementHeaderCell: UICollectionViewCell {

    @IBOutlet weak var collecView: UICollectionView!
    
    var room_list : [RoomListModel]? {
        didSet {
            guard room_list != nil else { return }
            collecView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collecView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kHeaderCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collecView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = kScreenW / 4
        let itemH = collecView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }
}

extension AmusementHeaderCell : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return room_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHeaderCellID, for: indexPath) as! CollectionGameViewCell
        cell.roomList = room_list?[indexPath.row]
        return cell
    }
}
