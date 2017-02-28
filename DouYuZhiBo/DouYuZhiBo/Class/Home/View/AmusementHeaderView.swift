//
//  AmusementHeaderView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/28.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kAmusementCellID = "kAmusementCellID"

class AmusementHeaderView: UIView {

    @IBOutlet weak var collecView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataArr : [[RoomListModel]]? {
        didSet {
            guard dataArr != nil else { return }
            
            collecView.reloadData()
            pageControl.numberOfPages = dataArr!.count
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collecView.register(UINib(nibName: "AmusementHeaderCell", bundle: nil), forCellWithReuseIdentifier: kAmusementCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collecView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collecView.bounds.size
        
    }
}

extension AmusementHeaderView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmusementCellID, for: indexPath) as! AmusementHeaderCell
        
        cell.room_list = dataArr?[indexPath.row]
        
        return cell
    }
}

extension AmusementHeaderView : UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
        
    }
}


extension AmusementHeaderView {

    class func amusementHeaderView() -> AmusementHeaderView {
        return Bundle.main.loadNibNamed("AmusementHeaderView", owner: nil, options: nil)?.first as! AmusementHeaderView
    }
    
}
