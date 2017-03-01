//
//  BaseViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/3/1.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var baseContentView : UIView?
    
    fileprivate lazy var animatorImageView : UIImageView = {[unowned self] in
        let animatorImageView = UIImageView()
        animatorImageView.center = self.view.center
        animatorImageView.bounds.size = CGSize(width: 151, height: 232)   //302 × 464
        animatorImageView.image = UIImage.animatedImageNamed("img_loading_", duration: 1.0)
        animatorImageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return animatorImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}


extension BaseViewController {

    func setupUI() {
        
        baseContentView?.isHidden = true
        
        view.addSubview(animatorImageView)

        view.backgroundColor = UIColor.white
    }
    
    func loadDataFinished() {
        
        baseContentView?.isHidden = false
        
        animatorImageView.isHidden = true
        
    }
}
