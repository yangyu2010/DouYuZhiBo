//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/14.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

fileprivate let TitleViewH: CGFloat = 35

class HomeViewController: UIViewController {

    fileprivate lazy var titleView: YYTitleView = {
    
        let frame = CGRect(x: 0, y: kNavigationH, width: kScreenW, height: TitleViewH)
        let titleView = YYTitleView(frame: frame, titles: ["推荐","手游","娱乐","游戏","趣玩"])
        titleView.backgroundColor = UIColor.brown
        return titleView
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
