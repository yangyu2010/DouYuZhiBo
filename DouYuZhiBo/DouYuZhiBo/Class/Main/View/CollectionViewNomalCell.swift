//
//  CollectionViewNomalCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/17.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CollectionViewNomalCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titLab: UILabel!
    @IBOutlet weak var nickNameLab: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    var room : RoomModel? {
        didSet {
            guard let room = room else { return  }
            
            nickNameLab.text = room.nickname
            
        }
    }
}
