//
//  YYContentView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/15.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let ContentCollectionViewCellID = "ContentCollectionViewCellID"

protocol YYContentViewDelegate : class {
    func yyContentViewScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

class YYContentView: UIView {

    // MARK: -自定义属性
    fileprivate var subVcs: [UIViewController] = [UIViewController]()
    fileprivate var parentVc : UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    weak var delegate: YYContentViewDelegate?
    fileprivate var isForbidScrollDelegate: Bool = false    //如果是点击tileView 这个时候不需要去走滑动的代理
    
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
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCellID)
        return collection
    }()
    
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
        
    }
}

// MARK: -collection代理
extension YYContentView : UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCellID, for: indexPath)
        cell.contentView.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        let vc = subVcs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
//        print("scrollViewWillBeginDragging")
//        print(originalOffsetX)
//        print("scrollViewWillBeginDragging")
        
        isForbidScrollDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        
        // 如果是点击事件,就不走下面的代理了
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffset = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffset < startOffsetX { //变小了 是往右边滑动 title变小一个
            
            progress = 1 - (currentOffset / scrollViewW - floor(currentOffset / scrollViewW))
            targetIndex = Int(currentOffset / scrollViewW)
            sourceIndex = targetIndex + 1

        }else { //大了 就是往左边滑动 title变大一个
            progress = currentOffset / scrollViewW - floor(currentOffset / scrollViewW)
            sourceIndex = Int(currentOffset / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= subVcs.count {
                targetIndex = subVcs.count - 1
            }
            
            //如果完全滑过去了 就处理值
            if currentOffset - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }

        }

        delegate?.yyContentViewScroll(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}


// MARK: -暴露方法
extension YYContentView {

    func scrollToIndex(index: Int) {
        
        // 这个是点击事件,然后不需要走滑动代理
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
