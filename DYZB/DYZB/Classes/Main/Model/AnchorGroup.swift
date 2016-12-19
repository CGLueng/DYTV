//
//  AnchorGroup.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/15.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {//监听属性变化,将字典数组中的字典再转模型
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchorArr.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    var tag_name : String = ""
    //组的图片
    var icon_name : String = "home_header_normal"
    //游戏图标
    var icon_url : String = ""
    
    //主播模型数组
    lazy var anchorArr : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    //防止没有用到的字典字段导致崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
