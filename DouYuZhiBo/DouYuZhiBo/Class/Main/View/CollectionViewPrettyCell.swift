//
//  CollectionViewPrettyCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/17.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: UICollectionViewCell {

    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nickNameLab: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    
    
    var room : RoomModel? {
        didSet {
            guard let room = room else { return  }
            
            nickNameLab.text = room.nickname
            if let city = room.anchor_city {
                cityBtn.setTitle(" " + city, for: .normal)
            }
            
            if let urlString = room.vertical_src ,
                let url = URL(string: urlString) {
                iconImg.kf.setImage(with: url)
            }
            
            if room.online >= 10000 {
                onlineBtn.setTitle("\(Int(room.online / 10000))万在线", for: .normal)
            }else {
                onlineBtn.setTitle("\(room.online)在线", for: .normal)
            }
        }
    }
}
