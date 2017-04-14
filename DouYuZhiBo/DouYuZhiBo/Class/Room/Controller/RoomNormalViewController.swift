//
//  RoomNormalViewController.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/3/1.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

private let cellID = "RoomNormalCellID"

class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    fileprivate lazy var roomTable : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        self.title = "直播吧";
        
        setupUI()
    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//
//    }
}


extension RoomNormalViewController {

    fileprivate func setupUI() {
        
        roomTable.frame = view.bounds
        roomTable.delegate = self
        roomTable.dataSource = self
        view.addSubview(roomTable)
        
        roomTable.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension RoomNormalViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 32
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "\(indexPath.item)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("删除")
    }
}

