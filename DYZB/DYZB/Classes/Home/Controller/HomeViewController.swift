//
//  HomeViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //1.设置导航栏
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        //设置左侧 item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //设置右侧 item
        let size = CGSize(width: 40, height: 40)
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", hightlightImage: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", hightlightImage: "btn_search_clicked", size: size)
//        let qrCodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", hightlightImage: "Image_scan_click", size: size)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightlightImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightlightImage: "btn_search_clicked", size: size)
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", hightlightImage: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrCodeItem]
        
    }
}
