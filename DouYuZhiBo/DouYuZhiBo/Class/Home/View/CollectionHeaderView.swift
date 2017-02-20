//
//  CollectionHeaderView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/17.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titLab: UILabel!
    
    var roomList : RoomListModel? {
        didSet {

            guard let roomList = roomList else { return }
            
            titLab.text = roomList.tag_name
            
            iconImg.image = UIImage(named: roomList.local_icon)
            
        }
    }
    
}
