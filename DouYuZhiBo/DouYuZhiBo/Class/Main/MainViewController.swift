//
//  MainViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/14.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }

    
    fileprivate func addChildVC(storyName: String) {
    
        // 1.通过storyboard获取控制器
        if let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController() {
        
            // 2.添加控制器
            addChildViewController(childVC)
        }

    }

    
}
