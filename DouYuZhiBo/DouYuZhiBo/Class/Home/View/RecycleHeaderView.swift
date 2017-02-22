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

    // MARK: -xib控件
    @IBOutlet weak var recycleCollecView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    // MARK: -系统回调函数
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
    
    // MARK: -自定义属性
    var recycleModelArr : [RecycleModel]? {
        didSet {
            guard recycleModelArr != nil else { return }
            
            // 1.刷新数据
            recycleCollecView.reloadData()
            
            // 2.设置pageController的总个数
            pageController.numberOfPages = recycleModelArr!.count
            
            // 3.设置collectionView滚动到中间某个位置
            let path = IndexPath(item: recycleModelArr!.count * 50, section: 0)
            recycleCollecView.scrollToItem(at: path, at: .left, animated: false)
            
            // 4.添加定时器
            addTimer()
        }
    }
    
    /// 定时器
    fileprivate var timer : Timer?
    
}

// MARK: -数据源
extension RecycleHeaderView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (recycleModelArr?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecycleCellID, for: indexPath) as! RecycleHeaderCell

        cell.model = recycleModelArr?[indexPath.item % recycleModelArr!.count]
        
        return cell
    }
    
}

// MARK: -代理
extension RecycleHeaderView : UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        let count = Int(offsetX / scrollView.bounds.width)

        pageController.currentPage = count % recycleModelArr!.count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

// MARK: -提供个类方法创建view
extension RecycleHeaderView {

    class func creatView() -> RecycleHeaderView {
        
        return Bundle.main.loadNibNamed("RecycleHeaderView", owner: nil, options: nil)?.first as! RecycleHeaderView
    }
}

// MARK: -处理timer
extension RecycleHeaderView {

    fileprivate func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        let currentOffsetX = recycleCollecView.contentOffset.x
        let offset = currentOffsetX + recycleCollecView.bounds.width
        
        recycleCollecView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}


