//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by CGLueng on 2016/12/13.
//  Copyright © 2016年 com.ruixing. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionViewBasicCell {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
//            //校验模型是否有值
//            guard let anchor = anchor else {return}
//            //在线人数
//            var onlineStr : String = ""
//            if anchor.online >= 10000 {
//                onlineStr = "\(Double(anchor.online / 10000).format(f: ".1"))万在线"
//            }else {
//                onlineStr = "\(anchor.online)在线"
//            }
//            onlineBtn.setTitle(onlineStr, for: .normal)
//            //昵称
//            nickNameLB.text = anchor.nickname
            //城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
