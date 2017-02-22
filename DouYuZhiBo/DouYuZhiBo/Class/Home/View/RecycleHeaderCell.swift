//
//  RecycleHeaderCell.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit
import Kingfisher

class RecycleHeaderCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    var model : RecycleModel? {
        didSet {
            guard let model = model else { return }
            
            titleLab.text = model.title
            
            if let urlString = model.pic_url ,
                let url = URL(string: urlString) {
                iconImg.kf.setImage(with: url)
            }
        }
    }
    
}
