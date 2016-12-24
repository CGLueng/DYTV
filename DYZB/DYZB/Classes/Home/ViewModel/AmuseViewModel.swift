//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/24.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class AmuseViewModel : BasicViewModel {

}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
