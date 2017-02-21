//
//  CollectionViewPrettyCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/17.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: CollectionViewBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
   
    
    override var room : RoomModel? {
        didSet {
            
            super.room = room
            
            cityBtn.setTitle(room?.anchor_city, for: .normal)
            
        }
    }
   
}
