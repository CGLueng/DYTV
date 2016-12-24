//
//  AmuseViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/24.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit


class AmuseViewController: BasicAnchorViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        //给父类的 viewmodel 赋值
        basicVM = amuseVM
        //请求数据
        amuseVM.loadAmuseData { 
            self.collectionView.reloadData()
        }
    }
}

