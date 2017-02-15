//
//  YYTitleView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/15.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

// 滑动底线的高度
fileprivate let kScrollLineViewH: CGFloat = 2

class YYTitleView: UIView {

    // MARK: -懒加载
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    fileprivate lazy var segmentView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.darkGray
        return vi
    }()
    
    fileprivate lazy var lineView: UIView = {
    
        let vi = UIView()
        vi.backgroundColor = UIColor.orange
        return vi
    }()
    
    // MARK: -自定义属性
    fileprivate var titles : [String] = [String]()
    
    // MARK: -构造函数
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        
        self.titles = titles
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: -设置UI
extension YYTitleView {

    fileprivate func setupUI() {
        
        // 1.添加scroll
        scrollView.frame = bounds
        addSubview(scrollView)

        let labY: CGFloat = 0
        let labW: CGFloat = scrollView.frame.width / CGFloat(titles.count)
        let labH: CGFloat = scrollView.frame.height
        
        // 2.添加底部分割线
        segmentView.frame = CGRect(x: 0, y: bounds.height - kSingleLineW, width: bounds.width, height: kSingleLineW)
        addSubview(segmentView)
        
        // 3.添加滑动的View
        lineView.frame = CGRect(x: 0, y: bounds.height - kScrollLineViewH, width: labW, height: kScrollLineViewH)
        addSubview(lineView)

        for (index,title) in titles.enumerated() {
            
            let lab = UILabel()
            lab.frame = CGRect(x: CGFloat(index) * labW, y: labY, width: labW, height: labH)
            lab.text = title
            lab.textAlignment = .center
            lab.textColor = UIColor.white
            
            scrollView.addSubview(lab)
        }
    }
}
