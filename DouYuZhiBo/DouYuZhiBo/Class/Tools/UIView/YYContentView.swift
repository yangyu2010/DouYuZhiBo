//
//  YYContentView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/15.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let ContentCollectionViewCellID = "ContentCollectionViewCellID"

class YYContentView: UIView {

    // MARK: -懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self!.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        collection.isPagingEnabled = true
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCellID)
        return collection
    }()
    
    // MARK: -自定义属性
    fileprivate var subVcs: [UIViewController] = [UIViewController]()
    fileprivate var parentVc : UIViewController?
    
    init(frame: CGRect, subVcs: [UIViewController], parentVc: UIViewController?) {
        
        super.init(frame: frame)
        
        self.subVcs = subVcs
        self.parentVc = parentVc
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -设置UI相关
extension YYContentView {

    fileprivate func setupUI() {
        
        collectionView.frame = self.bounds
        addSubview(collectionView)
        collectionView.dataSource = self
        
    }
}

// MARK: -collection代理
extension YYContentView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCellID, for: indexPath)
        cell.contentView.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        let vc = subVcs[indexPath.item]
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}


// MARK: -暴露方法
extension YYContentView {

    func scrollToIndex(index: Int) {
//        let path = IndexPath(item: index, section: 0)
//        collectionView.scrollToItem(at: path, at: .left, animated: false)
        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
