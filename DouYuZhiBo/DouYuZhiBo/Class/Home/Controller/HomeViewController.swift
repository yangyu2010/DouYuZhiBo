//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/14.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let TitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    fileprivate lazy var titleView: YYTitleView = {[weak self] in
        let frame = CGRect(x: 0, y: kNavigationH, width: kScreenW, height: TitleViewH)
        let titleView = YYTitleView(frame: frame, titles: ["推荐","游戏","娱乐","趣玩"])
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var contentView: YYContentView = {[weak self] in
        
        let frame = CGRect(x: 0, y:  kNavigationH + TitleViewH, width: kScreenW, height: kScreenH - kNavigationH - TitleViewH - kTabBarH)
        var subVcs = [UIViewController]()
        subVcs.append(RecommendViewController())
        subVcs.append(GameViewController())
        subVcs.append(AmusementViewController())
        subVcs.append(FunnyViewController())
        let contentView = YYContentView(frame: frame, subVcs: subVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: -设置UI相关
extension HomeViewController {

    fileprivate func setupUI() {
    
        // 0.设置nav不影响scroll 不然加的Label看不到
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置nav
        setupNavigationBar()
        
        // 2.添加titleView
        view.addSubview(titleView)
        
        // 3.
        view.addSubview(contentView)
//        contentView.delegate = self
    }
    
    
    fileprivate func setupNavigationBar() {
    
        // 1.左边的斗鱼图标
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", highImageName: "", size: CGSize.zero)
        
        // 2.右边的三个item
        let size = CGSize(width: 30, height: 30)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_clicked", size: size)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_clicked", size: size)
        navigationItem.rightBarButtonItems = [searchItem, qrcodeItem, historyItem]
        
    }
}


// MARK: -titleView代理
extension HomeViewController : YYTitleViewDelegate {

    func yyTitleViewScrollToIndex(index: Int) {
        contentView.scrollToIndex(index: index)
    }
    
}


// MARK: -contentView代理
extension HomeViewController : YYContentViewDelegate {

    func yyContentViewScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
