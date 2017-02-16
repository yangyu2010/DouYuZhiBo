//
//  YYTitleView.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/15.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

protocol YYTitleViewDelegate : NSObjectProtocol {
    
    func YYTitleViewScrollToIndex(index: Int)
    
}

// 滑动底线的高度
fileprivate let kScrollLineViewH: CGFloat = 3

class YYTitleView: UIView {

    // MARK: -自定义属性
    fileprivate var titles : [String] = [String]()
    fileprivate var originalIndex: Int = 0
    weak var delegate: YYTitleViewDelegate?
    
    // MARK: -懒加载
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor.white
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
    
    fileprivate lazy var labelArr: [UILabel] = [UILabel]()
    
    
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
            lab.font = UIFont.systemFont(ofSize: 16.0)
            lab.tag = index
            if index == 0 {
                lab.textColor = UIColor.orange
            }else {
                lab.textColor = UIColor.darkGray
            }
            scrollView.addSubview(lab)
            labelArr.append(lab)
            
            // 添加手势
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:)))
            lab.addGestureRecognizer(tap)
        }
    }
}


extension YYTitleView {

    @objc fileprivate func titleLabelClick(tap: UITapGestureRecognizer) {
        
        // 1.设置文字颜色
        let originalLab = labelArr[originalIndex]
        originalLab.textColor = UIColor.darkGray
        let currentLab = tap.view as? UILabel
        currentLab?.textColor = UIColor.orange
        
        // 2.取出当前是第几个
        if let currentIndex = currentLab?.tag,
            let currentLab = currentLab {
                
            originalIndex = currentIndex
            
            // 3.设置线滑动
            UIView.animate(withDuration: 0.3, animations: {
                self.lineView.frame.origin.x = CGFloat(currentIndex) * currentLab.frame.width
            })
            
            // 4.通知代理点击了第几个
            delegate?.YYTitleViewScrollToIndex(index: currentIndex)
        }
    }
}




