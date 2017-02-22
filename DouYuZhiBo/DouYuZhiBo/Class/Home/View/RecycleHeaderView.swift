//
//  RecycleHeaderView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let kRecycleCellID = "kRecycleCellID"

class RecycleHeaderView: UIView {

    @IBOutlet weak var recycleCollecView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()

        recycleCollecView.register(UINib(nibName: "RecycleHeaderCell", bundle: nil), forCellWithReuseIdentifier: kRecycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置layout 不能在xib里设置 因为xib里的大小还没固定下来
        let layout = recycleCollecView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = recycleCollecView.bounds.size
    }
    
    var recycleModelArr : [RecycleModel]? {
        didSet {
            guard recycleModelArr != nil else { return }
            
            recycleCollecView.reloadData()
            
            pageController.numberOfPages = recycleModelArr!.count
        }
    }
    
    
    
}

// MARK: -数据源
extension RecycleHeaderView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recycleModelArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecycleCellID, for: indexPath) as! RecycleHeaderCell

        cell.model = recycleModelArr?[indexPath.item]
        
        return cell
    }
    
}

// MARK: -代理
extension RecycleHeaderView : UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        let count = Int(offsetX / scrollView.bounds.width)
        
        pageController.currentPage = count
    }
}

// MARK: -提供个类方法创建view
extension RecycleHeaderView {

    class func creatView() -> RecycleHeaderView {
        
        return Bundle.main.loadNibNamed("RecycleHeaderView", owner: nil, options: nil)?.first as! RecycleHeaderView
    }
}


