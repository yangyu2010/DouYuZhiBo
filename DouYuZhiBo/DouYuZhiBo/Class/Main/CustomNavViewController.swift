//
//  CustomNavViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/3/1.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CustomNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.取出系统的手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.取出手势加在哪个view上
        guard let gesView = systemGes.view else { return }
        
        // 3.取出系统手势上的target和action
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        print(targetObjc)
        // 'class()' is unavailable in Swift: use 'dynamicType' instead
        // print(type(of: target))
        // UIGestureRecognizerTarget
        
        guard let tatget = targetObjc.value(forKey: "target") else { return }
//        guard let action = targetObjc.value(forKey: "action") as? Selector else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(tatget, action: action)
        
        // 5.添加到当前view上
        gesView.addGestureRecognizer(panGes)
        
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
    
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
