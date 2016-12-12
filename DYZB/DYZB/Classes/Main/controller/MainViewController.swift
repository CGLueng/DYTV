//
//  MainViewController.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/12.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sbArr : Array = ["Home", "Live", "Follow", "Profile"]
        for item in sbArr {
            addChildVC(storyName: item)
        }
    }
    
    // MARK:- 添加子控制器
    private  func addChildVC(storyName : String) -> () {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        addChildViewController(childVC!)
    }

}
