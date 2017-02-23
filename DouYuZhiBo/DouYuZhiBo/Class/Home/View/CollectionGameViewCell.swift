//
//  CollectionGameViewCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/22.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CollectionGameViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    var roomList : RoomListModel? {
        didSet {
            guard let roomList = roomList else { return }
            
            titleLab.text = roomList.tag_name
            
            if let urlString = roomList.icon_url ,
                let url = URL(string: urlString) {
                iconImg.kf.setImage(with: url, placeholder: UIImage(named: "live_cell_default_phone"))
            }else {
                iconImg.image = UIImage(named: "home_more_btn")
            }
        }
    }

}
