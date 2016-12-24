//
//  BasicViewModel.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/24.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class BasicViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BasicViewModel {
    func loadAnchorData(URLString: String, parameters: [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
        NetWorkingTools.requestData(type: .GET, URL: URLString, parameters: parameters) { (result) in
            //对结果进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            //便利字典
            for dict in dataArr {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            //完成回调
            finishedCallback()
        }
    }
}
