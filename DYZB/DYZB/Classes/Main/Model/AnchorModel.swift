//
//  AnchorModel.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/15.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
//    房间 id
    var room_id : Int = 0
    //房间图片
    var vertical_src : String = ""
    //判断是手机直播(1)还是电脑直播(0)
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //在线人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
         
    }
}
