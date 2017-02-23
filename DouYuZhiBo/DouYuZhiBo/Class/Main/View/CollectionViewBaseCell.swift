//
//  CollectionViewBaseCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var nickNameLab: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var onlineLab: UILabel!
    
    var room : RoomModel? {
        didSet {
            guard let room = room else { return }
            
            nickNameLab.text = room.nickname
            
            if let urlString = room.vertical_src ,
                let url = URL(string: urlString) {
                iconImg.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
            }
            
            if room.online >= 10000 {
                onlineLab.text =  "\(Int(room.online / 10000))万在线"
            }else {
                onlineLab.text =  "\(room.online)在线"
            }
        }
    }
}
