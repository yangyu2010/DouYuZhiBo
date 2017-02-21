//
//  CollectionViewNomalCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/17.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewNomalCell: CollectionViewBaseCell {

    @IBOutlet weak var titLab: UILabel!
 
    override var room : RoomModel? {
        didSet {
            
            super.room = room
            
            titLab.text = room?.room_name
      
        }
    }
}
