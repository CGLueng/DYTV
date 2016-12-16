//
//  CycleModel.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/16.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // MARK:- 属性
    var titile : String = ""
    var pic_url : String = ""
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor : AnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
